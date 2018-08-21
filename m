Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A562172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJ4ek/S9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A562172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeHUNJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:09:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeHUNJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:09:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so15319978wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vP5tQjueaKebpIG8lvKOk7rcE8hPPPF+Bwwq5gcPvA=;
        b=OJ4ek/S9uY4HWTlb42V92J7x5lvZeAJmKnAolKVf/jf0M34K4JAVMJiDBJO6PTi4Vi
         d4QyI/d/VhXnYvWyNPFlQdWLZF/cabYbMz+Nh1pltAoQ4+RYj9Ub9F3nEef7Bz++nYlZ
         UVT1uXjvbmUtjod0AKKK0nUTLih2Rmfzqsyfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vP5tQjueaKebpIG8lvKOk7rcE8hPPPF+Bwwq5gcPvA=;
        b=XDJsKx0rUSjZh4xGleK/KCJdRTfohetla4ejYjGNik0iP+80MzEt4G1gVweemelYUL
         IfjfsMxhO76Ekv5wiylRkYt0ltbUm5EPcSVaaO22QeUxNZU1I/tW4L5ktNqSNa81LP8O
         UM6JbPlu2WHdRLBL3x85a1dYnA7H/BVndEE8m5DbBM0YZyY/Lea9LhBTBYlWrl5ycftT
         bl48f2vrngrMJ4xcopUiGFKEJc0eFdh2VyjQBrTgdKWnzw41ioxAONDmPSPCcmidGo06
         gtAN3aq/hVytGO6Dd0SGbIph6wNsz6E4CuQ97Ytnu9wGa8OKNwvpiV4M11DKJMZE+Bgm
         3wkA==
X-Gm-Message-State: APzg51CEXyJco+0J+a+MYCAhoNXtbWDHXdPTu6/Tl4hifq8NG8Y5jeKe
        kYmftY3K4pjFHJuh0n6YTLoZbA==
X-Google-Smtp-Source: ANB0VdYmDkdLcMEkhhQjUjak1hfHDMYLTvonOBB4QbvJobyOJ0IeRDJbDsBuchJJNRp7OwL0EqGrZQ==
X-Received: by 2002:adf:a964:: with SMTP id u91-v6mr3430691wrc.140.1534845009128;
        Tue, 21 Aug 2018 02:50:09 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm3857097wmb.10.2018.08.21.02.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 02:50:08 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
Date:   Tue, 21 Aug 2018 10:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180820202038.5d3dc195@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/08/18 19:20, Boris Brezillon wrote:
> On Mon, 20 Aug 2018 11:43:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>>
>> Overall am still not able to clear visualize on how MTD bindings with
>> nvmem cells would look in both partition and un-partition usecases?
>> An example DT would be nice here!!
> 
> Something along those lines:
> 
This looks good to me.
> 	mtdnode {
> 		nvmem-cells {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			cell@0 {
> 				reg = <0x0 0x14>;
> 			};
> 		};
> 
> 		partitions {
> 			compatible = "fixed-partitions";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			partition@0 {
> 				reg = <0x0 0x20000>;
> 
> 				nvmem-cells {
> 					#address-cells = <1>;
> 					#size-cells = <1>;
> 
> 					cell@0 {
> 						reg = <0x0 0x10>;
> 					};
> 				};
> 			};
> 		};
> 	}; >

Just curious...Is there a reason why we can't do it like this?:
Is this because of issue of #address-cells and #size-cells Or mtd 
bindings always prefer subnodes?

	mtdnode {
		reg = <0x0123000 0x40000>;
		#address-cells = <1>;
		#size-cells = <1>;
		cell@0 {
			compatible = "nvmem-cell";
			reg = <0x0 0x14>;
		};

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;

			partition@0 {
				reg = <0x0 0x20000>;
				cell@0 {
					compatible = "nvmem-cell";
					reg = <0x0 0x10>;
				};
			};
		};
	};

Am okay either way!

thanks,
srini
