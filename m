Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF9C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146E21524
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C146E21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeHILjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:39:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbeHILjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:39:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so4522219wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QcH4pJaopmU/up96XV44/DtUIxFA5MrVIeFoiC5lvXM=;
        b=oDZ2jUwx0Dtde86Ljw8NaHcgruXVrlkwOoCWPLjwPPqacrV2Y2yDYbvOrJuQyQypzk
         vDCF2Ssk06+rVtbqsnIjm+gmYse3l6sePHSOXpLV9+iq/uevr5RW2zIk6qdOSOQD6MXS
         PHnwrNZnPJ9LJz35tMQy1wuZSrbRnBdOs4t2kfX+yaamyWTyHQoRGndO9wJn3G8HFpIe
         zav1e1Yciiph86KZgm8mjCaooRf0Gp1E/ELtMLtX8AZ5pQFkuDjzRrU6vKl9r1G72FBz
         A/y54sWOZa1Q+BQOS0yt+OW3uGvq8LtCV1M7DwxCExfAnIZQZEbz2mIu0AbIuqgK2T4D
         4A5w==
X-Gm-Message-State: AOUpUlEppoht2NFFVwKbtahah72f6MpfQs6dUfGJqjkySX1zpwGmSKH8
        zHTji5dUbgmHY3nldriTPoICdg==
X-Google-Smtp-Source: AA+uWPyezTgroMFKCmEqsKk0E+9tA2kbffI9S3ZNVSWHnXz+2M4DuxVmxUVacamvqT+C1zIF6ZeRog==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr813538wrr.117.1533806151423;
        Thu, 09 Aug 2018 02:15:51 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e133-v6sm11737179wma.33.2018.08.09.02.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:15:50 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
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
References: <20180808083006.31919-1-hdegoede@redhat.com>
 <20180808083006.31919-5-hdegoede@redhat.com>
 <20180808170014.izjkviwh67hfu3hz@ninjato>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <06718a13-8c68-e74f-df4c-64b9a928bdd4@redhat.com>
Date:   Thu, 9 Aug 2018 11:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808170014.izjkviwh67hfu3hz@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-08-18 19:00, Wolfram Sang wrote:
> 
> $subject still says "i2c:"

Ah, good point I will send a v5 with this fixed, I will also
do s/no_clients/num_clients/ for v5 as Andy requested.

Regards,

Hans
