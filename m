Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEFD20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEFD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeICVVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:21:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbeICVVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:21:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C0CC40241C6;
        Mon,  3 Sep 2018 17:00:24 +0000 (UTC)
Received: from [10.36.116.60] (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1672B100F350;
        Mon,  3 Sep 2018 17:00:18 +0000 (UTC)
Subject: Re: [PATCH] vfio: fix potential memory leak in vfio_msi_cap_len
To:     David Hildenbrand <david@redhat.com>, Li Qiang <liq3ea@gmail.com>,
        alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiang02@corp.netease.com
References: <1535374041-3551-1-git-send-email-liq3ea@gmail.com>
 <a6eb3c83-13c2-587a-557c-f1f072a0deff@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ab8ffb59-03fb-c794-4cf7-76c72473eaeb@redhat.com>
Date:   Mon, 3 Sep 2018 19:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6eb3c83-13c2-587a-557c-f1f072a0deff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 17:00:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 17:00:24 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li, David,

On 08/30/2018 04:15 PM, David Hildenbrand wrote:
> On 27.08.2018 14:47, Li Qiang wrote:
>> Free the vdev->msi_perm in error path.
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_config.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 115a36f6f403..62023b4a373b 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1180,8 +1180,10 @@ static int vfio_msi_cap_len(struct vfio_pci_device *vdev, u8 pos)
>>  		return -ENOMEM;
>>  
>>  	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
>> -	if (ret)
>> +	if (ret) {
>> +		kfree(vdev->msi_perm);
>>  		return ret;
>> +	}
>>  
>>  	return len;
>>  }
>>
> 
> Doesn't vfio_config_free() take care of that in all cases?

Looks OK to me.
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Looks vfio_config_free is called on vfio_pci_release whereas
vfio_msi_cap_len can fail in vfio_pci_open path.

Thanks

Eric
> 
