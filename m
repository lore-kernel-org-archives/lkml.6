Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045012085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045012085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJMT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:19:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36297 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeJJMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:19:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so1904258plt.3;
        Tue, 09 Oct 2018 21:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mf5xwyupM05Xh21TLsdTA4L7cMtb46NThE0pZbMCWoA=;
        b=PLURK8bXCx3M0Mq6GfNZzo5YNnG46YDNPvq3Oo1NCQHRJcnMnRoepLGG8IS1KZJ8OQ
         AKuumpQn2+kInVACqind4eBHQMFZcDkRH5Lty/B6qoJEHm5YtdJfjkakS449GSt07fOL
         3SO7Gk8I3Gr0P2dMF5vea9L9kQMKD61mZ3lR7uyoov/fY4ExXTslWB6CH+w8fVAPCdzo
         fDKzTjQEusWwy/H4h69r+5FLcbzTtUxZ2GLwCjXjvoTIv9r8EIc/d2RaxEgG6khOFCQX
         QLihgOlmfItbwcJK+ONUG+iPoKN7mSLJOUjq8fcheK4TgGs+La3j4AWw0gm4bfs3THl1
         vjJw==
X-Gm-Message-State: ABuFfojKKhECS8JTbo1DWCgzocDbxODUpkl4R6ULFhVB6NAJlyGZSbCe
        tLLzeCh8DcAbG88UsAprvVfWG8VjsCfcQQ==
X-Google-Smtp-Source: ACcGV60NGASlH15TJ+54we7gkZfsI0zNXSPv1LBbKJE+fM7/okB6T63RmVRfimZZPv7pQwOD9ps0Lg==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4-v6mr32092199plb.265.1539147546355;
        Tue, 09 Oct 2018 21:59:06 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id z25-v6sm30218344pfl.58.2018.10.09.21.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:59:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        target-devel <target-devel@vger.kernel.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f75e6879-65b2-2912-df6d-27133c0da779@acm.org>
Date:   Tue, 9 Oct 2018 21:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:23 PM, Nicholas A. Bellinger wrote:
> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index 86c0156..fc3093d2 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(struct kref *kref)
>   	if (se_sess) {
>   		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
>   		list_del_init(&se_cmd->se_cmd_list);
> -		if (list_empty(&se_sess->sess_cmd_list))
> +		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))
>   			wake_up(&se_sess->cmd_list_wq);
>   		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
>   	}
> @@ -2907,7 +2907,7 @@ void target_wait_for_sess_cmds(struct se_session *se_sess)
>   
>   	spin_lock_irq(&se_sess->sess_cmd_lock);
>   	do {
> -		ret = wait_event_interruptible_lock_irq_timeout(
> +		ret = wait_event_lock_irq_timeout(
>   				se_sess->cmd_list_wq,
>   				list_empty(&se_sess->sess_cmd_list),
>   				se_sess->sess_cmd_lock, 180 * HZ);

Since this patch addresses two different issues (performance improvement 
+ fix for a hang), I think it should be split in two patches.

Thanks,

Bart.


