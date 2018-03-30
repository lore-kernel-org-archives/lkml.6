Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeC3C1P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 22:27:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751893AbeC3C1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 22:27:13 -0400
Subject: Re: [PATCH net] vhost: validate log when IOTLB is enabled
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
 <20180329173438-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6d20da3-cebb-b672-ad4a-8e17083b7234@redhat.com>
Date: Fri, 30 Mar 2018 10:27:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329173438-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月29日 22:44, Michael S. Tsirkin wrote:
> On Thu, Mar 29, 2018 at 04:00:04PM +0800, Jason Wang wrote:
>> Vq log_base is the userspace address of bitmap which has nothing to do
>> with IOTLB. So it needs to be validated unconditionally otherwise we
>> may try use 0 as log_base which may lead to pin pages that will lead
>> unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).
>>
>> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
>> Reported-by:syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> One follow-up question:
>
> We still observe that get user pages returns 0 sometimes. While I agree
> we should not pass in unvalidated addresses, isn't this worth
> documenting?
> 	
>

Looking at get_user_pages_fast(), it has:

     if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
                     (void __user *)start, len)))
         return 0;

So this is expected I think.

Thanks
