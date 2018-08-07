Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78431C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369ED2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369ED2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeHGNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:47:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34800 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeHGNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:47:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so6754385eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLbiqXlCivL9wxDbMIvctgaeJzXvhGbhqG1ACmoZytc=;
        b=IGeiWAta3pW0xSj3yOdHSfiD2PbJ3F18tmgNB2Gdq1L1F65onGuilV3ahdLn5FNATY
         rUIzbNKLp10Kl+VdUrb+41oOUlkWG/wFndjz6tnBzR2JwvofRdGwiHUwVJWgK3FOIpJq
         O/WmXuExgd+6f91Bk1NJ+n9mvQ4Es5pkOaYjS/29e6qmY2eWBlYVZQn7ZyfeyqA7Pk6S
         mxUOfGphqWQ/VLB1MqYON/H+dcAVWUhsvVrdXoAjjPTCuP9I40jKKEn/rv0J8Op+oEIx
         6dY+fYWXyDtfvD/AXpH6EEJedyDAp16t4vGyruMq7Wf8Qg2xhpGDx8ZVkODej40DVieo
         Ep3w==
X-Gm-Message-State: AOUpUlEPBQQAGLSO4y3IyMFCy/ylQCdu3QTdRbQzRZGHL2HCKm4Q0vTI
        aJQqFEVXYfCtD8PYaRE4UK7pjIO59fM=
X-Google-Smtp-Source: AAOMgpfrAgK/YjpUmOQ/Xx5PyKIBCgPLCoEp5CqT/YCgjXt7xwgFv8b//tmllnTAQt27TNQQ0pORLg==
X-Received: by 2002:a50:bc03:: with SMTP id j3-v6mr23049135edh.34.1533641615152;
        Tue, 07 Aug 2018 04:33:35 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a15-v6sm1716271edd.47.2018.08.07.04.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 04:33:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
 <20180807112701.5iukqa6m5atf22fw@ninjato>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
Date:   Tue, 7 Aug 2018 13:33:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180807112701.5iukqa6m5atf22fw@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 13:27, Wolfram Sang wrote:
> Hi Hans,
> 
>> +I2C MULTI INSTANTIATE DRIVER
>> +M:	Hans de Goede <hdegoede@redhat.com>
>> +L:	linux-i2c@vger.kernel.org
> 
> Since this driver is about FW bugs, I wonder if
> platform-driver-x86@vger.kernel.org isn't the better list here?

Ok, fixed for v4.

>> +S:	Maintained
>> +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c
> 
> I2C parts of the rest looks good from a glimpse...

Thanks.

Regards,

Hans
