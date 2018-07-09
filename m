Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C79C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF66E20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PbhcekRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF66E20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbeGIRck (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:32:40 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46470 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbeGIRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:32:38 -0400
Received: by mail-qk0-f196.google.com with SMTP id o2-v6so10097950qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E2Zkmg08Q99VWA5BH3V8y+i+d564WjwvrOWgpsGzxYg=;
        b=PbhcekRZ91r98YgbanmEUEbhGpyoxXARcgl4ixpc0IEOUnaPDwCqTzGk7VoaVUm/+F
         kb0XuLvMYSrhK2uv3ONKyg45WWcf05wzNaGl1PL1/EBjW9nsNtvKQ6ZlQ1N0PJm+bekr
         xjvFa32fs8OxjgKxT8EbEIoZBN5pMuUotuHHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2Zkmg08Q99VWA5BH3V8y+i+d564WjwvrOWgpsGzxYg=;
        b=b8fzJk/jofb5nwmd6HRt41c6ng+oMlJhXARfIaU4eHdP6t/RCWEls8gpnF2xI/p/+G
         GLd7gYagyoBA4UM6G5GI+M/gCMqiNL4n3sNNQO+2A/+JlQHc98QAFl37BeT+OLxZ4BKR
         YhvZ5Rqd152PMX84ZlbCITdzWPQLmbg9IWnbjhWbBYA1ydVPNJSxQH1rSyyQPwuPZMQf
         FsIIwUbt+gDYu/54EmjG52ZPxLtbdPNRcf76OGmVdViV3AO/rBLa7K/cMYldnUGmHyzS
         y1+VViegO3ieFAdHhSr1kzDHiyZ0xGk7eLpo6f/KYYX6veaujxIiyZIfFB5iWETGoOS7
         Czdg==
X-Gm-Message-State: APt69E0Y5IqWxDB7jm67V/u/wQKSYsAO/7BL3au8BcRS13GkWem09Go4
        mDC6N2EFqXPfK0/MAPhtiFt7zg==
X-Google-Smtp-Source: AAOMgpdxiMs+XXp8bpOHEjbjKWIztGEvcouOZJtkfyFrItCEzMqdANTeMOH7tcWRC1XLRzxT0tygmQ==
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr17961153qkd.32.1531157557510;
        Mon, 09 Jul 2018 10:32:37 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h10-v6sm8516654qtm.48.2018.07.09.10.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:32:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
To:     poza@codeaurora.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
 <8c6d5faccee6723ccb635f538105f1cc@codeaurora.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a1dd602a-2b06-602b-399f-18f882193cbd@broadcom.com>
Date:   Mon, 9 Jul 2018 10:32:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8c6d5faccee6723ccb635f538105f1cc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Could you please help to review/ack this patch, based on the following 
comments from Lorenzo?

 > apart from patch 1, that requires Bjorn's ACK, I would take the
 > series (I will rewrite the logs)

Thanks,

Ray

On 6/12/2018 1:30 AM, poza@codeaurora.org wrote:
> On 2018-06-12 05:51, Ray Jui wrote:
>> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
>> the following PCIe device ID:
>> 0xd750, 0xd802, 0xd804
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  drivers/pci/quirks.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 2990ad1..47dfea0 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
>>  }
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, 
>> quirk_paxc_bridge);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, 
>> quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, 
>> quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, 
>> quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, 
>> quirk_paxc_bridge);
>>  #endif
>>
>>  /* Originally in EDAC sources for i82875P:
> 
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
