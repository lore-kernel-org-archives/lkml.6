Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F6C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACEE20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfARRLg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:11:36 -0500
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:39736
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:11:35 -0500
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7755052; Fri, 18 Jan 2019 17:11:31 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   kernel@martin.sperl.org
In-Reply-To: <20190115212539.GK5522@sirena.org.uk>
Date:   Fri, 18 Jan 2019 18:11:31 +0100
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk> <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org> <20190115212539.GK5522@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

Just got access to my computer back for the weekend ;)

> On 15.01.2019, at 22:25, Mark Brown <broonie@kernel.org> wrote:
> 
> On Tue, Jan 15, 2019 at 09:58:55PM +0100, Martin Sperl wrote:
> 
>> I may find some time over the weekend if no solution
>> has been found until then.
> 
> Thanks for volunteering :)

I actually brought this about so I see is as part of my
responsibility trying to solve the issue as well...
> 
>> The way I would envision it it would have a “state”
>> as a level (0=shutdown, 1=hw enabled, 2=in pump, 
>> 3=in transfer, 4=in hw-mode,...) and a complete
>> to allow waking the shutdown thread (and by this
>> avoiding the busy wait loop we have now).
>> This would replace those idling, busy, and running flags.
> 
> That's a good idea, yes - a single enum much more reflects what we can
> actually do in terms of transitions.

Does something like this looks acceptable?

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ec210286567c..677fc5025033 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -288,6 +288,21 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 	module_driver(__spi_driver, spi_register_driver, \
 			spi_unregister_driver)

+/* define SPI Controller states in the state machine */
+enum spi_controller_state {
+	SPI_CONTROLLER_STATE_SHUTDOWN		= 0,
+	SPI_CONTROLLER_STATE_IDLE		= 1,
+	SPI_CONTROLLER_STATE_IN_PROCESS		= 2,
+	SPI_CONTROLLER_STATE_IN_TRANSFER	= 3,
+};
+
+/* define SPI Controller mode */
+enum spi_controller_mode {
+	SPI_CONTROLLER_MODE_NORMAL	= 0, /* normal spi mode */
+	SPI_CONTROLLER_MODE_MEM		= 1, /* memory mode using mem_ops */
+	SPI_CONTROLLER_MODE_EXCLUSIVE	= 2, /* could replace bus_lock_flag */
+};
+
 /**
  * struct spi_controller - interface to SPI master or slave controller
  * @dev: device interface to this driver
@@ -332,14 +347,16 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @pump_idle_teardown: work structure for scheduling a teardown delayed
  * @queue_lock: spinlock to syncronise access to message queue
  * @queue: message queue
- * @idling: the device is entering idle state
  * @cur_msg: the currently in-flight message
  * @cur_msg_prepared: spi_prepare_message was called for the currently
  *                    in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
+ * @controller_state: defines the current state of the controller
+ *                    state machine
+ * @controller_state_changed: wakeup of threads interrested in getting
+ *                            notified about a mode change (primarily pm)
+ * @controller_mode: defines the current mode of the controller
  * @xfer_completion: used by core transfer_one_message()
- * @busy: message pump is busy
- * @running: message pump is running
  * @rt: whether this queue is set to run as a realtime task
  * @auto_runtime_pm: the core should ensure a runtime PM reference is held
  *                   while the hardware is prepared, using the parent
@@ -524,9 +541,9 @@ struct spi_controller {
 	spinlock_t			queue_lock;
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
-	bool				idling;
-	bool				busy;
-	bool				running;
+	enum spi_controller_state	controller_state;
+	struct completion		controller_state_changed;
+	enum spi_controller_mode	controller_mode;
 	bool				rt;
 	bool				auto_runtime_pm;
 	bool                            cur_msg_prepared;


SPI_CONTROLLER_MODE_EXCLUSIVE could replace the bus_lock_flag.
I am also not sure of the “convention” of memory mode (i.e
using mem_ops). Is it maybe implicitly spi_bus_locked - i.e
typically only a single device?

Essentially we would transition between these states linearly
(hopefully no jumps are needed).

Martin
