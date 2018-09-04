Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D66C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FBB20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FBB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIDOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:47:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52008 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIDOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:47:16 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w84AMi3Y080627;
        Tue, 4 Sep 2018 19:22:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 04 Sep 2018 19:22:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w84AMdoX080577
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Sep 2018 19:22:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] security: tomoyo: Fix obsolete function
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-security-module@vger.kernel.org
References: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
Cc:     takedakn@nttdata.co.jp, linux-kernel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e8154180-666e-2541-26d9-87d3f5eb3719@I-love.SAKURA.ne.jp>
Date:   Tue, 4 Sep 2018 19:22:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/04 17:41, Ding Xiang wrote:
> simple_strtoul is obsolete, and use kstrtouint instead
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

> ---
>  security/tomoyo/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 03923a1..9b38f94 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -1660,7 +1660,8 @@ static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
>  	head->r.eof = true;
>  	if (tomoyo_str_starts(&buf, "global-pid "))
>  		global_pid = true;
> -	pid = (unsigned int) simple_strtoul(buf, NULL, 10);
> +	if (kstrtouint(buf, 10, &pid))
> +		return;
>  	rcu_read_lock();
>  	if (global_pid)
>  		p = find_task_by_pid_ns(pid, &init_pid_ns);
> 
