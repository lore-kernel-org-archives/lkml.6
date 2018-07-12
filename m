Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82320C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E82320C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbeGLCIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:08:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:52139 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbeGLCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:08:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6C21Tmq015528;
        Wed, 11 Jul 2018 21:01:32 -0500
Message-ID: <e25f7a0b1d529b57a2994681101a3633849cdc1b.camel@kernel.crashing.org>
Subject: Re: [PATCH 06/14] fsi: master-gpio: Add more tracepoints
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Jul 2018 12:01:29 +1000
In-Reply-To: <CACPK8XfZPCiCPeNL5-TpPMcHrA_fyiLu=5pArSxBXd6wT8jkFA@mail.gmail.com>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
         <20180626232605.13420-7-benh@kernel.crashing.org>
         <CACPK8XfZPCiCPeNL5-TpPMcHrA_fyiLu=5pArSxBXd6wT8jkFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 13:41 +0930, Joel Stanley wrote:
> On 27 June 2018 at 08:55, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > This adds a few more tracepoints that have proven useful when
> > debugging issues with the FSI bus.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> > ---
> >  drivers/fsi/fsi-master-gpio.c          | 16 ++++---
> >  include/trace/events/fsi_master_gpio.h | 59 ++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> > index 48e0e65b2982..a00a85aa6d56 100644
> > --- a/drivers/fsi/fsi-master-gpio.c
> > +++ b/drivers/fsi/fsi-master-gpio.c
> > @@ -130,10 +130,17 @@ static void set_sda_output(struct fsi_master_gpio *master, int value)
> > 
> >  static void clock_zeros(struct fsi_master_gpio *master, int count)
> >  {
> > +       trace_fsi_master_gpio_clock_zeros(master, count);
> >         set_sda_output(master, 1);
> >         clock_toggle(master, count);
> >  }
> > 
> > +static void echo_delay(struct fsi_master_gpio *master)
> > +{
> > +       clock_zeros(master, master->t_echo_delay);
> > +}
> 
> This doesn't look like it belongs in this patch.
> 
> You've just moved it up. Not worth a re-spin.

I've done more, I made it use clock_zeros() instead of open coding it
in order to share the tracepoint.
> 
> > +
> > +
> >  static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
> >                         uint8_t num_bits)
> >  {
> > @@ -279,16 +286,19 @@ static void build_ar_command(struct fsi_master_gpio *master,
> >                 addr_bits = 2;
> >                 opcode_bits = 2;
> >                 opcode = FSI_GPIO_CMD_SAME_AR;
> > +               trace_fsi_master_gpio_cmd_same_addr(master);
> > 
> >         } else if (check_relative_address(master, id, addr, &rel_addr)) {
> >                 /* 8 bits plus sign */
> >                 addr_bits = 9;
> >                 addr = rel_addr;
> >                 opcode = FSI_GPIO_CMD_REL_AR;
> > +               trace_fsi_master_gpio_cmd_rel_addr(master, rel_addr);
> > 
> >         } else {
> >                 addr_bits = 21;
> >                 opcode = FSI_GPIO_CMD_ABS_AR;
> > +               trace_fsi_master_gpio_cmd_abs_addr(master, addr);
> >         }
> > 
> >         /*
> > @@ -337,12 +347,6 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
> >         msg_push_crc(cmd);
> >  }
> > 
> > -static void echo_delay(struct fsi_master_gpio *master)
> > -{
> > -       set_sda_output(master, 1);
> > -       clock_toggle(master, master->t_echo_delay);
> > -}
> > -
> >  static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
> >  {
> >         cmd->bits = 0;
