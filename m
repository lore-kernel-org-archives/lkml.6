Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCOIjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:39:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCOIja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:39:30 -0400
Subject: Re: [PATCH net-next] tuntap: XDP_TX can use native XDP
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520997820-8289-1-git-send-email-jasowang@redhat.com>
 <20180314053424-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <21e53c2b-6677-fc9a-0771-e895da1c257f@redhat.com>
Date: Thu, 15 Mar 2018 16:39:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314053424-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月14日 11:37, Michael S. Tsirkin wrote:
>>   			return NULL;
>>   		case XDP_TX:
>> -			xdp_xmit = true;
>> -			/* fall through */
>> +			get_page(alloc_frag->page);
>> +			alloc_frag->offset += buflen;
>> +			if (tun_xdp_xmit(tun->dev, &xdp))
>> +				goto err_redirect;
>> +			tun_xdp_flush(tun->dev);
> Why do we have to flush here though?
> It might be a good idea to document the reason in a code comment.
>

ndo_xdp_xmit() does not touch doorbell, so we need a ndo_xdp_flush() 
here. It's the assumption of XDP API I think, so not sure it's worth to 
mention it here.

Thanks
