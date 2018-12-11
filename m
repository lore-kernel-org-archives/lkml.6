Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2030C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CA82082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CA82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLKKCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:02:15 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:27925 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:02:14 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBBA2Dcp045957;
        Tue, 11 Dec 2018 19:02:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Tue, 11 Dec 2018 19:02:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBBA28bj045924
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 11 Dec 2018 19:02:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <77864d48-ce55-a699-ee6e-60d9ec36e305@i-love.sakura.ne.jp>
Date:   Tue, 11 Dec 2018 19:02:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/11 10:16, Liu, Chuansheng wrote:
> We may enhance it by:
> -       if (sysctl_hung_task_warnings) {
> +       if (sysctl_hung_task_panic || sysctl_hung_task_warnings) {
>                 if (sysctl_hung_task_warnings > 0)
>                         sysctl_hung_task_warnings--;

Why ignore sysctl_hung_task_warnings? The administrator can already
configure as sysctl_hung_task_warnings == -1 && sysctl_hung_task_panic == 1
if he/she does not want to suppress neither sched_show_task() nor
debug_show_all_locks()/trigger_all_cpu_backtrace(). Someone might want
that sysctl_hung_task_warnings == 0 (which is a request to suppress only
sched_show_task()) should not be ignored by sysctl_hung_task_panic == 1
(which is a request to trigger panic).

