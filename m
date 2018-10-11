Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EBC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DB82086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-iscsi.org header.i=@linux-iscsi.org header.b="ipWBL3Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-iscsi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJKNVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:21:49 -0400
Received: from mail.linux-iscsi.org ([67.23.28.174]:45342 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeJKNVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:21:49 -0400
Received: from [192.168.1.66] (75-37-194-224.lightspeed.lsatca.sbcglobal.net [75.37.194.224])
        (using SSLv3 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nab)
        by linux-iscsi.org (Postfix) with ESMTPSA id AB32C40ABD;
        Thu, 11 Oct 2018 05:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1539237375; bh=AGzWeC5o5upQ7SeKXw97j9lLWY0ir6V
        NZZKIqtm+e3o=; h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        b=ipWBL3MqMxtGoSUwwToaSzRN/pTJawcURp0ukQ5jZ1Tqme2iMzDJtKT3jczf0lQhT
        kqRFs3WcDdcXlzl2pS4qXbCcyDBiYet0EHiu47yB4J1IJmnpVp0EruW2yaM0Lyh1cbc
        AndDbJ59TJCpyEmiEX+Sz5R0EylIBSOIxjY91+Y=
Message-ID: <1539237365.6150.32.camel@haakon3.daterainc.com>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     "Ly, Bryant" <bly@catalogicsoftware.com>,
        target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        bly@catalogicsoftware.com
Date:   Wed, 10 Oct 2018 22:56:05 -0700
In-Reply-To: <5BBE2FBF.7080804@redhat.com>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
         <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
         <5BBE2FBF.7080804@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello MNC & Co,

On Wed, 2018-10-10 at 11:58 -0500, Mike Christie wrote:
> On 10/09/2018 10:23 PM, Nicholas A. Bellinger wrote:
> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
> > signals will be pending for task_struct executing the normal session shutdown
> > and I/O quiesce code-path.
> > 

<SNIP>

> > diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> > index 86c0156..fc3093d2 100644
> > --- a/drivers/target/target_core_transport.c
> > +++ b/drivers/target/target_core_transport.c
> > @@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(struct kref *kref)
> >  	if (se_sess) {
> >  		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
> >  		list_del_init(&se_cmd->se_cmd_list);
> > -		if (list_empty(&se_sess->sess_cmd_list))
> > +		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))
> 
> I think there is another issue with 00d909a107 and ibmvscsi_tgt.
> 
> The problem is that ibmvscsi_tgt never called
> target_sess_cmd_list_set_waiting. It only called
> target_wait_for_sess_cmds. So before 00d909a107 there was a bug in that
> driver and target_wait_for_sess_cmds never did what was intended because
> sess_wait_list would always be empty.
> 
> With 00d909a107, we no longer need to call
> target_sess_cmd_list_set_waiting to wait for outstanding commands, so
> for ibmvscsi_tgt will now wait for commands like we wanted. However, the
> commit added a WARN_ON that is hit if target_sess_cmd_list_set_waiting
> is not called, so we could hit that.
> 
> So I think we need to add a target_sess_cmd_list_set_waiting call in
> ibmvscsi_tgt to go along with your patch chunk above and make sure we do
> not trigger the WARN_ON.
> 

Nice catch.  :)

With target_wait_for_sess_cmd() usage pre 00d909a107 doing a list-splice
in target_sess_cmd_list_set_waiting(), this particular usage in
ibmvscsi_tgt has always been list_empty(&sess->sess_wait_list) = true
(eg: no se_cmd I/O is quiesced, because no se_cmd in sess_wait_list)
since commit 712db3eb in 4.9.y code.

That said, ibmvscsi_tgt usage is very similar to vhost/scsi in the
respect individual /sys/kernel/config/target/$FABRIC/$WWN/$TPGT/
endpoints used by VMs do not remove their I_T nexus while the VM is
active.

So AFAICT, ibmvscsi_tgt doesn't strictly need target_sess_wait_for_cmd()
at all if this is true.

