Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDIOmm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:42:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39114 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeDIOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:42:25 -0400
X-Google-Smtp-Source: AIpwx496Jk1eedmj3xPuRoEtyIz5h0FmCJleBo0SwpJHUESKyORK6RimdL4vAfAOt6l43DLtnzmrOw==
Subject: Re: [PATCH] net: dccp: Replace GFP_ATOMIC with GFP_KERNEL in
 dccp_init
To: Jia-Ju Bai <baijiaju1990@gmail.com>, gerrit@erg.abdn.ac.uk,
        davem@davemloft.net
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523283004-25581-1-git-send-email-baijiaju1990@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8216dee8-5e52-421e-026a-4c75d654be54@gmail.com>
Date: Mon, 9 Apr 2018 07:42:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523283004-25581-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 07:10 AM, Jia-Ju Bai wrote:
> dccp_init() is never called in atomic context.
> This function is only set as a parameter of module_init().
> 
> Despite never getting called from atomic context,
> dccp_init() calls __get_free_pages() with GFP_ATOMIC,
> which waits busily for allocation.

What do you mean by "waits busily" ?

GFP_ATOMIC does not sleep, does not wait.

> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> to avoid busy waiting and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
