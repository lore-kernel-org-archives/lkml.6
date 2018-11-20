Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA0C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD9A20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P+k5vhuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD9A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeKUIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:23:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42304 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKUIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:23:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so2224446pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uvxnaqTOvXGjxWsWDuA15+9lToHGFO0k6T9ZxHeLSNg=;
        b=P+k5vhuJcVlWJTC6bigSK2G6IBKPfk/Yg81nJimIdyEBfSDEjV+sWrqOPq7w+jkIKO
         r99oWOVqU+6UMTk5Wh4JwVPhtbVsWkOtzIRR6opzRgDIHIq/2wiEIj+jWi/qGh1T/fGE
         fIsHegrWO7xdXE2i8e5itdwghxw25yvFktllI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uvxnaqTOvXGjxWsWDuA15+9lToHGFO0k6T9ZxHeLSNg=;
        b=Am/SEuK3NO3CqZ4nne8YwEkVgkdtl8jtuUW2zEt71+YRf5wgfQLrGwqtvEdHsDawUd
         QJ2SE8NQuAnxMTeq4PQGvL5zThFDDX5en6zq/Hr5mveOHvmK44NvYQwF/w60ETLvOYg8
         V3xZKNXtZl6L5JDWxiTQOP6fMYss2HXzv2Kjni2AQAevXf9GA0wSzqKkGO6HvAvsr/dC
         IK77koSQAhOASMugXAF4rDglKYTW+Yl1BM+K0djE2kGMfj7ZftaqV4IgQR4GFSnVY9x8
         j3hO3lcK9ym4u7l6kM5NOo7g2dTAbz6cfSRDE7aW1EbHPvIuS5r3Amz0QyiRTa02qjcI
         Lq7A==
X-Gm-Message-State: AGRZ1gJZwOFRHHau80MMk+/nqaI8CPLJxcqviiBoVmPtpOcWBBVN3fkj
        xgRKLbWtBooKBKoqQMuIZz396w==
X-Google-Smtp-Source: AJdET5eqd1GxosPZF3k8G5g3ek/i1XTcwDkp9zSG7BrlzFKkKg30QsA5lMYxenWeQzg1YjKvW4UVSQ==
X-Received: by 2002:a62:89d7:: with SMTP id n84-v6mr3996725pfk.255.1542750755104;
        Tue, 20 Nov 2018 13:52:35 -0800 (PST)
Received: from [10.69.36.116] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u19-v6sm51509435pfh.153.2018.11.20.13.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 13:52:34 -0800 (PST)
Subject: Re: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
To:     John Garry <john.garry@huawei.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        dick.kennedy@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
References: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
 <16c3b882-6e0e-b712-b4d6-78f68172da65@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <34556d50-562b-43b2-873f-ba68056e5af5@broadcom.com>
Date:   Tue, 20 Nov 2018 13:52:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <16c3b882-6e0e-b712-b4d6-78f68172da65@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 1:40 AM, John Garry wrote:
>
> please ensure that you maintain alignment with opening brackets 

I don't think this is a requirement.  From the rules I've read 
preference is tabs-only indentation.  Spacing (less than a tab), after 
tabs, for open brace alignment is allowed, thus is coder's choice.

-- james





