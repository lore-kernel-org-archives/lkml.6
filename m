Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeC1QcW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:32:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38850 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeC1QcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:32:20 -0400
X-Google-Smtp-Source: AIpwx4/kn3DpNzPN98fCY7s/A9P1XtHW0IkN4JzHMs/pTRay7qKqjRdEksn4zbvZofctLkDwrrEudA==
Subject: Re: net_tx_action race condition?
To: Saurabh Kr <krsaurabh@juniper.net>,
        Angelo Rizzi <angelo.rizzi@3dautomazione.it>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sarvendra Vikram Singh <svikrams@juniper.net>,
        Kunal Sharma <skunal@juniper.net>
References: <BY2PR05MB712796CB064F3202FEFA328B3A30@BY2PR05MB712.namprd05.prod.outlook.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7f70cdb4-4205-169a-0204-fd5cd72b44f1@gmail.com>
Date: Wed, 28 Mar 2018 09:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BY2PR05MB712796CB064F3202FEFA328B3A30@BY2PR05MB712.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/28/2018 12:30 AM, Saurabh Kr wrote:
> Hi Eric/Angelo,
>  
> We are seeing the assertion error  in linux kernel 2.4.29  “*kernel: KERNEL: assertion (atomic_read(&skb->users) == 0) failed at dev.c(1397)**”.* Based on patch provided (_https://patchwork.kernel.org/patch/5368051/_ ) we merged the changes in linux kernel 2.4.29 but we are still facing the assertion error at dev.c (1397). Please let me know your thoughts.
>  
> *Before Merge**(linux 2.4.29)*
> ---------------------------------
>  
> static void net_tx_action(struct softirq_action *h)
> {
>         int cpu = smp_processor_id();
>  
>         if (softnet_data[cpu].completion_queue) {
>                 struct sk_buff *clist;
>  
>                 local_irq_disable();
>                 clist = softnet_data[cpu].completion_queue; // Existing code
>                 softnet_data[cpu].completion_queue = NULL;
>                 local_irq_enable();
>  
>                 while (clist != NULL) {
>                         struct sk_buff *skb = clist;
>                         clist = clist->next;
>  
>                         BUG_TRAP(atomic_read(&skb->users) == 0);
>                         __kfree_skb(skb);
>                 }
>         }
>  
>          ---------
>  
> *After Merge the changes based on available patch**(linux 2.4.29)**:*
> ------------------------------------------------------------------------------
>  
> static void net_tx_action(struct softirq_action *h)
> {
>         int cpu = smp_processor_id();
>  
>         if (softnet_data[cpu].completion_queue) {
>                 struct sk_buff *clist;
>  
>                 local_irq_disable();
>                 clist = *(volatile typeof(softnet_data[cpu].completion_queue) *)&( softnet_data[cpu].completion_queue);  // Modified line based on available patch
>                 softnet_data[cpu].completion_queue = NULL;
>                 local_irq_enable();
>  
>                 while (clist != NULL) {
>                         struct sk_buff *skb = clist;
>                         clist = clist->next;
>  
>                         BUG_TRAP(atomic_read(&skb->users) == 0);
>                         __kfree_skb(skb);
>                 }
>         }
>   ………….
>  
> Thanks & regards,
> Saurabh
>  

Thats simply prove (again) that this 'fix' was not the proper one.

I have no idea what is wrong, and there is no way I am going to look at 2.4.29 kernel...
