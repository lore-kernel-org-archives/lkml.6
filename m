Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCZVKR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:10:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49908 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeCZVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:10:16 -0400
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Cyrill Gorcunov <gorcunov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        mhocko@kernel.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180326183725.GB27373@bombadil.infradead.org>
 <20180326192132.GE2236@uranus>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0bfa8943-a2fe-b0ab-99a2-347094a2bcec@i-love.sakura.ne.jp>
Date: Tue, 27 Mar 2018 06:10:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326192132.GE2236@uranus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/03/27 4:21, Cyrill Gorcunov wrote:
> That said I think using read-lock here would be a bug.

If I understand correctly, the caller can't set both fields atomically, for
prctl() does not receive both fields at one call.

  prctl(PR_SET_MM, PR_SET_MM_ARG_START xor PR_SET_MM_ARG_END xor PR_SET_MM_ENV_START xor PR_SET_MM_ENV_END, new value, 0, 0);

Then, I wonder whether reading arg_start|end and env_start|end atomically makes
sense. Just retry reading if arg_start > env_end or env_start > env_end is fine?
