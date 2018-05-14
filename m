Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeENBxC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:53:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751362AbeENBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:53:00 -0400
Subject: Re: [PATCH net V2] tun: fix use after free for ptr_ring
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
 <CAM_iQpU4YCrcp2XfAyFaUNtjLUi7SyoQ8exzMV7XnoW-=LV3sg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5f0589c9-356c-1661-34cf-3e3ee179164c@redhat.com>
Date: Mon, 14 May 2018 09:52:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpU4YCrcp2XfAyFaUNtjLUi7SyoQ8exzMV7XnoW-=LV3sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月12日 01:39, Cong Wang wrote:
> On Thu, May 10, 2018 at 7:49 PM, Jason Wang <jasowang@redhat.com> wrote:
>>   static void __tun_detach(struct tun_file *tfile, bool clean)
>>   {
>>          struct tun_file *ntfile;
>> @@ -736,7 +727,8 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>>                              tun->dev->reg_state == NETREG_REGISTERED)
>>                                  unregister_netdevice(tun->dev);
>>                  }
>> -               tun_cleanup_tx_ring(tfile);
>> +               if (tun)
>> +                       xdp_rxq_info_unreg(&tfile->xdp_rxq);
>>                  sock_put(&tfile->sk);
>>          }
>>   }
>> @@ -783,14 +775,14 @@ static void tun_detach_all(struct net_device *dev)
>>                  tun_napi_del(tun, tfile);
>>                  /* Drop read queue */
>>                  tun_queue_purge(tfile);
>> +               xdp_rxq_info_unreg(&tfile->xdp_rxq);
>>                  sock_put(&tfile->sk);
>> -               tun_cleanup_tx_ring(tfile);
>>          }
>>          list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
>>                  tun_enable_queue(tfile);
>>                  tun_queue_purge(tfile);
>> +               xdp_rxq_info_unreg(&tfile->xdp_rxq);
>>                  sock_put(&tfile->sk);
>> -               tun_cleanup_tx_ring(tfile);
> Are you sure t is safe?
>
> xdp_rxq_info_unreg() can't be called more than once either,
> please make sure the warning that commit c13da21cdb80
> ("tun: avoid calling xdp_rxq_info_unreg() twice") fixed will not
> show up again.

I think it's safe. xdp_rxq_info_unreg() will be called when socket were 
detached from netdevice, and there's only two possible paths: release() 
and uninit(). We've synced them through rtnl lock.

Thanks
