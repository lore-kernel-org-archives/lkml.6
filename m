Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8D72077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8D72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJKAVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKAVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1F35306B661;
        Wed, 10 Oct 2018 16:58:41 +0000 (UTC)
Received: from [10.10.121.111] (ovpn-121-111.rdu2.redhat.com [10.10.121.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 547465D9D1;
        Wed, 10 Oct 2018 16:58:40 +0000 (UTC)
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        target-devel <target-devel@vger.kernel.org>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5BBE2FBF.7080804@redhat.com>
Date:   Wed, 10 Oct 2018 11:58:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 10 Oct 2018 16:58:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 10:23 PM, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
> signals will be pending for task_struct executing the normal session shutdown
> and I/O quiesce code-path.
> 
> For example, iscsi-target and iser-target issue SIGINT to all kthreads as
> part of session shutdown.  This has been the behaviour since day one.
> 
> As-is when signals are pending with se_cmds active in se_sess->sess_cmd_list,
> wait_event_interruptible_lock_irq_timeout() returns a negative number and
> immediately kills the machine because of the do while (ret <= 0) loop that
> was added in commit 00d909a107 to spin while backend I/O is taking any
> amount of extended time (say 30 seconds) to complete.
> 
> Here's what it looks like in action with debug plus delayed backend I/O
> completion:
> 
> [ 4951.909951] se_sess: 000000003e7e08fa before target_wait_for_sess_cmds
> [ 4951.914600] target_wait_for_sess_cmds: signal_pending: 1
> [ 4951.918015] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 0
> [ 4951.921639] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 1
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 2
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 3
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 4
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 5
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 6
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 7
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 8
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 9
> 
> ... followed by the usual RCU CPU stalls and deadlock.
> 
> There was never a case pre commit 00d909a107 where wait_for_complete(&se_cmd->cmd_wait_comp)
> was able to be interruptted, so to address this for v4.19+ moving forward go ahead and
> use wait_event_lock_irq_timeout() instead so new code works with all fabric drivers.
> 
> Also for commit 00d909a107, fix a minor regression in target_release_cmd_kref()
> to only wake_up the new se_sess->cmd_list_wq only when shutdown has actually
> been triggered via se_sess->sess_tearing_down.
> 
> Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  drivers/target/target_core_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index 86c0156..fc3093d2 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(struct kref *kref)
>  	if (se_sess) {
>  		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
>  		list_del_init(&se_cmd->se_cmd_list);
> -		if (list_empty(&se_sess->sess_cmd_list))
> +		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))

I think there is another issue with 00d909a107 and ibmvscsi_tgt.

The problem is that ibmvscsi_tgt never called
target_sess_cmd_list_set_waiting. It only called
target_wait_for_sess_cmds. So before 00d909a107 there was a bug in that
driver and target_wait_for_sess_cmds never did what was intended because
sess_wait_list would always be empty.

With 00d909a107, we no longer need to call
target_sess_cmd_list_set_waiting to wait for outstanding commands, so
for ibmvscsi_tgt will now wait for commands like we wanted. However, the
commit added a WARN_ON that is hit if target_sess_cmd_list_set_waiting
is not called, so we could hit that.

So I think we need to add a target_sess_cmd_list_set_waiting call in
ibmvscsi_tgt to go along with your patch chunk above and make sure we do
not trigger the WARN_ON.

>  			wake_up(&se_sess->cmd_list_wq);
>  		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
>  	}
> @@ -2907,7 +2907,7 @@ void target_wait_for_sess_cmds(struct se_session *se_sess)
>  
>  	spin_lock_irq(&se_sess->sess_cmd_lock);
>  	do {
> -		ret = wait_event_interruptible_lock_irq_timeout(
> +		ret = wait_event_lock_irq_timeout(
>  				se_sess->cmd_list_wq,
>  				list_empty(&se_sess->sess_cmd_list),
>  				se_sess->sess_cmd_lock, 180 * HZ);
> 


