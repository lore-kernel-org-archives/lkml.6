Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759511AbeD1CX0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:23:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759307AbeD1CXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:23:24 -0400
Subject: Re: [PATCH net] vhost: Use kzalloc() to allocate vhost_msg_node
To: Kevin Easton <kevin@guarana.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a5b2b1056a86e98c@google.com>
 <20180427154502.GA22544@la.guarana.org>
 <20180427185501-mutt-send-email-mst@kernel.org>
 <20180428010756.GA27341@la.guarana.org>
 <20180428015106.GA27738@la.guarana.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0dcd15ae-cd9b-1e3c-1311-4d86d1aa51d2@redhat.com>
Date: Sat, 28 Apr 2018 10:23:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428015106.GA27738@la.guarana.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月28日 09:51, Kevin Easton wrote:
> On Fri, Apr 27, 2018 at 09:07:56PM -0400, Kevin Easton wrote:
>> On Fri, Apr 27, 2018 at 07:05:45PM +0300, Michael S. Tsirkin wrote:
>>> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
>>>> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>>>> so it should be allocated with kzalloc() to ensure all structure padding
>>>> is zeroed.
>>>>
>>>> Signed-off-by: Kevin Easton <kevin@guarana.org>
>>>> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>>> Does it help if a patch naming the padding is applied,
>>> and then we init just the relevant field?
>>> Just curious.
>> No, I don't believe that is sufficient to fix the problem.
> Scratch that, somehow I missed the "..and then we init just the
> relevant field" part, sorry.
>
> There's still the padding after the vhost_iotlb_msg to consider.  It's
> named in the union but I don't think that's guaranteed to be initialised
> when the iotlb member of the union is used to initialise things.
>
>> I didn't name the padding in my original patch because I wasn't sure
>> if the padding actually exists on 32 bit architectures?
> This might still be a conce

Yes.

print &((struct vhost_msg *)0)->iotlb
$3 = (struct vhost_iotlb_msg *) 0x4


>
> At the end of the day, zeroing 96 bytes (the full size of vhost_msg_node)
> is pretty quick.
>
>      - Kevin

Right, and even if it may be used heavily in the data-path, zeroing is 
not the main delay in that path.

Thanks
