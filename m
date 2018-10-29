Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A280C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E162420851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="mDYYOmTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E162420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeJ2RiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:38:16 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:29244
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbeJ2RiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVbpLsR13j8zpTnoVTUcBz3tEZlmQEcM4LUA0SAkn6Y=;
 b=mDYYOmTMD9M2IbzB6l0jKgpHEwNP52hZpyClSUslpQu9GVzOAd70Zifti4riQgt/RDF1GV8O8EhK8YCFQPm18lEQtWZGwz6IR0EXcvYj37aLi+f34KPY//MFxOU8Tec7h9hD9qGZWYQBKz9w+C4lv8pH/kS3R4JgOtLGQ9xxr/Q=
Received: from VI1PR06CA0099.eurprd06.prod.outlook.com (2603:10a6:803:8c::28)
 by DB4PR06MB523.eurprd06.prod.outlook.com (2a01:111:e400:983a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19; Mon, 29 Oct
 2018 08:50:28 +0000
Received: from HE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::203) by VI1PR06CA0099.outlook.office365.com
 (2603:10a6:803:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.20 via Frontend
 Transport; Mon, 29 Oct 2018 08:50:28 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT057.mail.protection.outlook.com (10.152.11.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 08:50:26 +0000
Received: from cernfe04.cern.ch (188.184.36.41) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 29 Oct
 2018 09:50:14 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 29 Oct 2018 09:50:13 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date:   Mon, 29 Oct 2018 09:50:15 +0100
Message-ID: <5352289.A0jT2G1FDH@pcbe13614>
In-Reply-To: <87woq438li.fsf@dell.be.48ers.dk>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <4222986.LvGMQbjSbS@pcbe13614> <87woq438li.fsf@dell.be.48ers.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR06MB523;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e745c8a9-d0e9-4d0b-14d4-08d63d7b9307
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB4PR06MB523;
X-MS-TrafficTypeDiagnostic: DB4PR06MB523:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR06MB523;20:8VRfCQuZSE4bjq4Ba93eIECibUXynoBtEI1E3ONZfjnXfzkQq04/vH6KfAaCM8U0ht2N/IM7WZ7rY+BidO0EJEA+0wQAz6wYXAAE7AvVE1SD80ApXsQD8CDtF/U1J8L0eQrf2pEcWOE5RMpXmAdAIXyO9Y8nn3+UIr/7uwpWyGWOsvJT7mlj7N7cGmY3TXkMNaVTodfMR6EG2ZcR4DrBXa3YA7xfQQn8ArJCKifQOxGwkLus04/tIymqS3MaaW2vw1YOaVZLanJAiKC4oXR1uU7+4pwMKam2zKLbVh60cYEAyLAt6eG5zCJTsaj4jS5vD7wmPbn5khPGHQNR4+T+A1YCtcdgC97qlAwTqK4NADzaP95dGA3XVLgpHZDAY6hOjeVTd2iqAnsj6ftZhFr+p0AHITXElQxvVJGtCvJ5F0xK7XyprAza+bv0oByvywVikAYnUPheqBhrsEMbXlLjjcxNQmDUYeNfPM+n31HOSQqO3xxWctOqUb+ZWO9sHjS2;4:7I7puvtquB/AuuxI7JE70pqONstcs0ttIPNu+AbRZtFngZLBB+lQEV7SrPzdq2YZxPPNmPfRhcsM+iz6mHSlVqO5hJyDcblf8Y0fKL8iusBav9btShgvZb8cyUk/LknNE5A+rO2I54yTdCIJxkY5UxL1JcwnuP997gbFhhvmHcmbTHdZ9lB670o557/mh8Mx/zsEOa2Zwp0akHysVsNxqWSKISfDbnRDSyA6kpCuZhl1HD8eZbYfNyTs/p9ohi2+QG2zMhsrdOU50BcMzFOecg==
X-Microsoft-Antispam-PRVS: <DB4PR06MB523E9F8A4524DCD71933AF1EFF30@DB4PR06MB523.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231382)(7700054)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095)(7701012);SRVR:DB4PR06MB523;BCL:0;PCL:0;RULEID:;SRVR:DB4PR06MB523;
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: 1;DB4PR06MB523;23:hWyW3lEEVmN/b+ML3SG+y0hDrRMzCiuu5Fgn37am/q0ZqeRKSo/uOU1We6mqZLUNERxIugVlBxksSV0oNyhLDYB84KUoO63+7DW6YaY8vLjywHAGjMiq0H62ZRysTg86F3bhvqAl6+srBldiUj268Xn4yCu2DnIb0upJJAsX1/qELACADBSezGaUUaX8yrH1;6:Qu6K784o09sJgjIuX3rGZQqOI+h9QFWnDZ8Y8Up5Z9WrvTFBOI+Q39tmxGrV35zOIv8TLn6va7U2KQD38XRK2IaA6+moNL6B1zsNSkz08nn3eXh4CUxsDq0inSWOj1D+s6H2IX07hB6g4MYkx11D5hwgEFmQjuIhPZEHtzWkGC+ikb7wdLdaL3X7VWxucQRu3ldP/YmyUvQbEH+SJzGF3LsnT0FC+TJKJKeXMqqe4z2+/Vo0CNlPubWkUbVCSmi2wRKFfTRkrJ1mD+6gt7Syrf4AjVHJAB1ve+oOjjxIK5IekPOm3OPcdZib1e19tbrTMbBr1tWTjnu7rRk0LwkW85lCEIkoYEiYD2D4IgrUezg0If7edKdoQ/FgMNRN02/gFUIcOo+bLGz+0auVNPO2QKRSNe2JqAZ6abPLvwQx/gJT/x73ocV6yBjh+b2eQFqIkVI19BYLkx4ioW+ZnNWrIA==;5:Z5BFJxonuc5qH0+50zKbIb0Hca8dhlKOPh1bVEJbk3JZHiH/IKmSLsn3HZf2thk8AwBB0XfegRvSvqX5ZWoOSg/BbhDRjpVXV6tn8XGchHMgd2uHxu5LEngA2CamfbI8tMtIVqrrdWvseHUeL+UnYO/JAuUQnF/k6lxiQwMiJNQ=
X-Microsoft-Antispam-Message-Info: YEZswnsl8Rvsqx1siklLUzdn64cmxmiPvcMqFhA9HPO3rBxN4Yr5c4dm8Qc8IdpGCX++XKA+IgXzfO4MTV6l/pdwU3MLWhXzvemUtgHRchkQd029VbD8Z16yMBWKrM1EQSNyv7Impx7y6DD56GY21eycjmld0fgSG1MV4JE1wmOnU9D/5CDNOEN87j+HwiA9JRqLXpRTaOj+jdeE2G3FhkrNpHNzad90hYVKkGrp71Hb5uf+Vh0kwC/B4/QAVOxfGU+Nkv7v4MSCQ4h4wzjGe37KA3iVT0ePB+3uysUSXI60xlI0c4EZdIBWiomM8+SfJJTBe+QooQXb5k5C7o8AVfwFkcGA1CRGRZzEFRd8h8MYmjADVQDI6Lj+2yisnBbxoqc6kfbXkc69TR/ZKbXxUQf7FDYTdmuSXF7Itkj8ouonRsPfblaOb63mcb/nYjZQwllgl+UqCJAQF0V08r+Rl7elpE8T6UBG+Dy2CRZlsSw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB4PR06MB523;7:LYgEsnyQBOYlETXBCAsWcGk/MKLtHocEllAW71bYc7m3ytXPPy4ysCBZbOsPwReAsHhva8ek88ul2X3R9HCnyu+4Oky0eBEiZrdKW2JoOs585UUSuHu4dRBpADQS3W0CJE5OxtNdHTQVRDddWJdKVA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 08:50:26.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e745c8a9-d0e9-4d0b-14d4-08d63d7b9307
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR06MB523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Friday, October 26, 2018 7:45:29 PM CET Peter Korsgaard wrote:
> >>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:
> Hi,
> 
>  >> > -       } else
>  >> > +       } else {
>  >> > 
>  >> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
>  >> > 
>  >> > +       }
>  >> 
>  >> This looks unrelated to $SUBJECT.
>  > 
>  > Do you prefer a different patch just for styling?
> 
> Yes please, it is a lot nicer to keep functional changes from pure style
> changes.

Ok

>  >> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
>  >> > +{
>  >> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits
>  >> > */
>  >> > +       u8 loop_on;
>  >> > +
>  >> > +       usleep_range(sleep_min, sleep_min + 10);
>  >> 
>  >> Where does this 10 come from?
>  > 
>  > It's true, it's just a random number. It can be zero as well, and we ask
>  > the system to just sleep for that amount of time.
>  > 
>  > (1) usleep_range(sleep_min, sleep_min);
> 
> Or just usleep(sleep_min);

This does not exist as far as I know; the alternative is an active wait with 
udelay. But then, it is not that different from just start polling TIP or BUSY 
flags.

I think that something like this could be better

(2) usleep_range(sleep_min, sleep_min * XXX);

But.
Since it is better to make this patch ready for xfer_irqless, then I will 
definitively go for udelay(). The reason is that, xfer_irqless may run in 
atomic context where we can't sleep at all.


