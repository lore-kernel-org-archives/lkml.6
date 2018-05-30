Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935982AbeE3GNl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:13:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44729 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935202AbeE3GNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:13:38 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix "Sleep inside atomic section"
 warning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180529163716.3886-1-thierry.escande@linaro.org>
Date: Wed, 30 May 2018 08:13:35 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CEB5894A-50FD-4541-8531-5EB73200771D@holtmann.org>
References: <20180529163716.3886-1-thierry.escande@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

> This patch fixes the following warning during boot:
> 
> do not call blocking ops when !TASK_RUNNING; state=1 set at
> [<(ptrval)>] qca_setup+0x194/0x750 [hci_uart]
> WARNING: CPU: 2 PID: 1878 at kernel/sched/core.c:6135
> __might_sleep+0x7c/0x88
> 
> In qca_set_baudrate(), the current task state is set to
> TASK_UNINTERRUPTIBLE before going to sleep for 300ms. It was then
> restored to TASK_INTERRUPTIBLE. This patch sets the current task state
> back to TASK_RUNNING instead.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f05382b5a65d..51790dd02afb 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -910,7 +910,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> 	 */
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
> -	set_current_state(TASK_INTERRUPTIBLE);
> +	set_current_state(TASK_RUNNING);
> 

However wouldn’t it better to use msleep or similar instead of open coding it with schedule_timeout?

Regards

Marcel
