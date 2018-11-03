Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C6DECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BB520833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UJ1BG2yZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KaAZAvdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BB520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeKDDEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48822 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbeKDDEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hpx2v030375;
        Sat, 3 Nov 2018 10:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Lf26zlNZXyra+pVlrPREtDy2tZQ8BLVn2IuQNyCWPwI=;
 b=UJ1BG2yZvIyNB3MmeS/HHjkybGtDrotTlBi9rVBFbCHgAmz6Y+ppsGrb4sl2Oxl6rzCb
 qzxp/YcbCi7qzEFP0JTtGJuIqH/iOKK2k/69yUfCSUdQyRAaKba3qDjGKGYhJUD/4Uun
 7jLBn/bFW2PqEBQ4VLOKfsJK4lXx4SLFmVVCZYNy5YAQa4UykpUZcw875dCtFu5MXIHW
 +/cyxqG2GNmFIQv/KQQRH2Us4JCIeOW9tqJ9Zjzt943y329kFG8rEM/Tj/vGk9GYYGs+
 NXnj7XwZunEhlU2yGa00W2xot1MX+GnUCKeYyI2baL3Sy3xjJnMbpHgr36RYwwwkNuCv vQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0184.outbound.protection.outlook.com [216.32.180.184])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf26zlNZXyra+pVlrPREtDy2tZQ8BLVn2IuQNyCWPwI=;
 b=KaAZAvdxReAvQOKUJhtiEl12AmmauiyIxB55hFusg+nM6GB6+G31IqhrlSrGy5J9ms16i6U8XGLT4BKx2z8Imurxq+Wa6pZo2np+fn2t1lf2Sv7dyqPX7JSHUklo93y3YYKJGcmWZPF6WUGrsB0ArIRf6x/caHLVvMHEc19NLNY=
Received: from BYAPR07CA0051.namprd07.prod.outlook.com (2603:10b6:a03:60::28)
 by BY1PR0701MB1861.namprd07.prod.outlook.com (2a01:111:e400:51ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.26; Sat, 3 Nov
 2018 17:52:24 +0000
Received: from CO1NAM05FT043.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0051.outlook.office365.com
 (2603:10b6:a03:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.26 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT043.mail.protection.outlook.com (10.152.96.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:23 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqMu5027370
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:27 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:27 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x7000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:21 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqBNF006456;
        Sat, 3 Nov 2018 17:52:11 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqBDd006454;
        Sat, 3 Nov 2018 17:52:11 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 09/14] usb:cdns3: Ep0 operations part of the API
Date:   Sat, 3 Nov 2018 17:51:22 +0000
Message-ID: <1541267487-3664-10-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(36092001)(189003)(199004)(2906002)(26826003)(478600001)(51416003)(4326008)(107886003)(217873002)(14444005)(36756003)(87636003)(4720700003)(486006)(476003)(50226002)(6916009)(356004)(126002)(6666004)(26005)(76176011)(11346002)(336012)(2616005)(426003)(8936002)(48376002)(8676002)(7636002)(47776003)(446003)(16586007)(54906003)(316002)(42186006)(50466002)(86362001)(246002)(5660300001)(105596002)(305945005)(2351001)(106466001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1861;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT043;1:3tm7PIQJ8Lp3S8tVkyEIXGakB0tAZGq7+AtFruxVbEFQ0SfnAtfFzQa4tDecL5eNU+ZRTNSjbJU4IMRjFVW5+1/XVgGjUCoR6lTpDos6gn7XO4WXoVRFpd3bBjFLuvc8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a475b78-c37e-4bca-f777-08d641b51c6d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BY1PR0701MB1861;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;3:TMStII9nCX8Rex4l4HmdZAjoV0ymkStQ9pQRXmt1KDY7sI+Mp361ZuRGNC5NKDUg3cZswBRaYKrN5jGgazygLi9uyLhNC3rBK8mTNde2zH7KdbmxJcB+NU9Q5Zq6xe/2DvL03uNEiRXB8mKQZKI8AREvnwJ9+dfdlHExEdhTCTJ2XDBLYQPCnz9me2KVHJtUv2oWVddF4FkoIg/gK5hUJSh+2ca2TQBhbFbjxqK8wveBdX7yQyTVpAK7xRAurTVU4f5woOuxTIs3OZdXPQVNJHhDjt9AwzdRsbsYBP0m81TCJiYKd9DhTLjT/YY+8eoSDci5j8nEhoiGOxk4QpB6ulG+W4xM/cYZsy/fdlR1VFc=;25:1t6aEbFDyvLmWWbOFYYGP4+0OljG2oz5SUnJ667E3vopGnclCTKS6RAArhOOfrPEr+6bcG/iVi57NQyV83S+HqTd/wAlqrjSQoE2eCI60YSZnhmiY47bqsGa39lUk2FOQVplliBnG6gJiAV1u13QhrywMziClB8BdXQ36/qTsUFoohYMT0M4zO7nSMxcs0SXYqE1AKA2GsER5O85CZ/97Ap7Fo5uAoCqjzMGFNnj1nalSHdeiw8eMBsxWmHLVep0/beuoFC771T4aP+H42iyRMUKVou97NDCucZVGjYygNpb35JbHr35HfS2Q8zN1lKqj7v2pfSUiIKJaGGRZem0yg==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1861:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;31:CXWXInXzp5fhPQWZoReldE+0gpR5WmieBXlf8LwDEhK9spD3jazdHc7RXeoIpRV47NA/YURTXtS4LcIm0HgLYPEZR2OqUyUdvno224EFaG/aYFWQBQbaFOuX7S08yNwxyfmmMAFOjj6yJyUbjo7Cxw842zJW1FhOU5kgzxCQ/ULjHgEWaDwc/PsqzKOLaaSlVFayvHy1N9TtXZhoXisaW313mnrdHZ7q/1Ng2gpwSWk=;20:n2vpZO+eakUlgkQsk0Ilbiae3RReW8bAL/kRCEUMl6X/e4Di3gtmsoRAihwSdxZrPo2yXHScZA7+d6aZufWn8Sy6ttuFDpmB5pzjxmjNIohFk+XdwMrz2zSsuXvqTYmsOfKX+IeVWwAlIsackdfxMTMm0uhysaXqXVpT/51+8ogP+G9OUaA4aPH6piI53fKdWJz2XuZOyjiyppOaFwJSPtgsvOK580Yn/e3oD52TGv4oyxoC1Y+5g2xXGKPk7de2Pa4oC/Yu6fdSL3GSAEApYl7ynbKsnSA40C0VZ4rCsVpk0HsAiuui19c8+3jBScA5YHuw0WmioC9AstrEj36b0f931HqdDj54XjN+M1+wp/DtwisC9n/RWqLFVKcqHKMJwCDffHQDb+2BYp5HJ+rmhe/TdYJOxdJd8jK2U/hS0hNn7OB4ztrwT/yk4Pqy4yDNNSO3YCSbv5vwE6OavT7xg4ccfLYinmbHeETtz+OxW3aAG/rWt0bN/vPRsbln72yD
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1861472A0DE6D0B5FE62280DDDC80@BY1PR0701MB1861.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231382)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1861;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1861;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;4:svccJ3GSnw2AiS6aFtxOL4NB3ywwDr4NDiNqPmLE1xLWxmUwJmSEh/hPEZoXgM9iY7xTkyW8hrPghtKkIjBr1WuOlUoYOjlFvSCasx+lHMI+OqXTsM62ZYsbNsm5jJaozqzlsHR18OcMl8G66wJWKhO6LHIi5zqLbw+FWMn2GP2FO9aoI7c9Bt8YDoUwthvkv/vba+trPfsjhd9MyNOv4gELOO5yGr4Vc1rbO0XavSNiTJUVMDsPcMBn/c1+L6jEG2yPC/q4hW+xjmw0YwgDPqHSnw9Kow4Bar10Qfo68xCDAxK6ieiTFA0dPtzWsyo/
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1861;23:2Pysu82iWhDDg1ca/wmdzQJn9u7wUjlGM9T1JR6?=
 =?us-ascii?Q?11oSDDr3H/GIaE2cYIZoBOPxq1kxlBLNihCZsWR4UEAJOlt0ZdssHazYc22i?=
 =?us-ascii?Q?ioUhcm5sM5upVCReuK5E/HgWpNoTTHdayRNph8nzf8GB6mW9wG6HFCOT1koM?=
 =?us-ascii?Q?LvTtKxA7JgLvPR+ayHJIdDWUpmhxHfO0ozXWv0jO+6c8dIssHP3HCKOyAxZL?=
 =?us-ascii?Q?ZYFeAkGCblnPOq6j63vvT8O7md4o0yipmPwiCZhYCby/YSYFA9zWp6ZDoFNR?=
 =?us-ascii?Q?isHhQcndVzbryw1hqFTZJPPx8825XKfgT6DohvGsasItCu8rYASltu2o6ttG?=
 =?us-ascii?Q?I3jDokcJjKIkIn47qOr0oqix447BbTfScxuWwER5ZzIzHQbtKdH4RhEkzI9D?=
 =?us-ascii?Q?sjz5QCS7oWkExsdmWhdjs1MOzGxeCMa2DDrrePE1CpcQhaERU74hzwyeAXbs?=
 =?us-ascii?Q?CYoPGQbjkTxmuTdndcuaKctYQ/JY2s5+0fEor8gfe0NMcJwVzoJexrfQH6sK?=
 =?us-ascii?Q?NZlhfPgcjjqEvMrxosCltkSJJhXfZSXq5/JX7bx5zNo5pd7ZNfjvNbbMLzDU?=
 =?us-ascii?Q?Hvc4It1BeELDiBsyxXyvryDAcnkCG95OIyL4abp8XUuR6tEtES5Uo89kjOzs?=
 =?us-ascii?Q?GzjSVj8UkT5xUPwoeG993ELUy6lQfbXxb19KeXSnnDiR6bC2Vmnd3Hpg9wJY?=
 =?us-ascii?Q?GpiY1iJZl5Dhz8Pd5eoLQbwUNPfF+9tzUAun65Y3l9LG0zmJvhFQHaH5WLcI?=
 =?us-ascii?Q?kKzEhG/2zdfzsTm+nXjoSTcqz8FCY+qnBHZBjqgCpm9pkJbh207ybO1Fh3gM?=
 =?us-ascii?Q?s/pUVIdxTGOwOM/TAOYLPLQf0Dr7wppes52cegLEjV6eOusy8B/ucEIQoCCC?=
 =?us-ascii?Q?/TmaHgk21DpIWJzegtXhVo2DRXc5jONv+J+kNWpsPFoWuNU+/JpLRIzuBCiZ?=
 =?us-ascii?Q?g5zoCG3ir6Cri6SxpdRlfqfjgC4VU6UIFELVwsMjRwRqnz3DZebOX2e2P8MM?=
 =?us-ascii?Q?atJpThQX27kDoOb5I8NV3YePI6/iqju8xlmpOpLObF2fVbhYUGZVLZkLNbdM?=
 =?us-ascii?Q?HKqds40RnCqqbDDnEjCwQOcgKwbXcpJAzWHsBPXA4ZIiC/Sv5iw/3OMtw0lL?=
 =?us-ascii?Q?clL7wWcio5FZFxQSdmAJZ5OI/LXklSBDSkI71iRKWWb7ZvC4W+2xq7w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: uKd3r33uc0ytV6uWtEkgcW84hq7E2PlvhArMr+UJyB5UOdRjEZTgy+6wAnrzstmK4tOhzj/oZ3Uxev+9Vna9m9j06CqMgrnyNHMXdC8wG+vz4/n87KrJ60ejkqCIRfvR0a6UXXRLdqQ6/MQ398Bld8xGta+4qStKMsrwdEsoChXwXfep401UxEnVjodPISLM4Tx0yWJwpMAqtimQMyOp2PhKptvJV31ZJK0M6zXfWsejN0Y4HDDi2HfQapEzq4KSSPvPjRfFptdDtrYsLbS/V64vvD2hMY3pHEjMZJCSLk01umfY8c65CTMXK5IspC3rBxvjv9e3/1xWkgh036jzn2l/0mr57BD+3n0C4kIIlng=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;6:Yv+msC5eaGPTlEeYxDHCTwS7fZxnDA94BHsNWd5f5wlZVZZzDCot0NaT3Fpgd+YK3sQPpoJTWZpSG7pls0D+TFBimHkhQa62ru0dE93MCj5a1HODBrkL/4SNzwKDRjH1TVl/KxTFNySI+8BW2vghC2hSUPuFGgevLXBdCmoIh7QnlyY5GdseejqnafF3hdlrueFLptB9CqYTQhkeOABSYdHUcJKiMRcsR4Xgaeoir5XWlhOXvTa8DQELL9kS5tIYK6H3zFik1NWf9XS4GYdKPutaRmMH7g9Y6sa05YBNnwQBSQ/zvn6gWF3mrCcpzJWtqfPjISfMuwXILLZ40OMCm0EH+5OYGADpJ82w4FOvN5VvRL+oGr4iL/sJbvXVLqER1o4vMehMsvIvJNTusWIvwAYdeNI9Tf3sTM3larqyutQ6WaQaHyFHGuAcENkXTLeouUrj5E4oQci0eu054coQoQ==;5:T5EcPmHBXzl7eWk+TaKJIoXmE8LwMwIDqlWnk6OvFhGAfzYIX9qLech1xOcQ1pDo81BmBwFu74TKjv+JMIiXgaOZSFdtl6RU6LdezII4ibX9grdNM08ojyc6Nit7ADglBeq9z9cSewnEXa10o2E238uCd8gbDBbhVCmahrcEc64=;7:kHCMZcVWkmHEcGpyfazhkAOV5g/e8FeQcd6QuklDsAMQAo+MSxwbdd1kgRhnP8m+T9LZlEU96ngVWHf4TIqmeQEjWGR9LH2l3AomLQF4Nsyzj0cK/VL5yZ4UWRXBHLz3XnvYsLrnwlqA73PRl4JhBQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;20:iRkg3iv4GWMyGiyZdm58LIWtT9bray18dIHQF0ec8HrZTb5DRcump7yDFrNXDPfrA+AdOYdNlWcHJKQnI3V3Rbr9ff0dHgk6ESfNpJJhClFocE9pMb6Ca7kfI97jvR43gJ+GD80UHvDNSBmDAMPDp15mUkZxOG0uarGx6sejC3198xdBctTiHwZGgjajK5KrGyy5EoFQJ3Bt0q1n/YYKPVqRz2DT79Hrn3MAlIPTG/7i9KtqDozPs03Rbsb0pwOd
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:23.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a475b78-c37e-4bca-f777-08d641b51c6d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1861
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements related to default endpoint callback functions
defined in usb_ep_ops object

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/ep0.c    | 188 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.c |   8 ++
 drivers/usb/cdns3/gadget.h |  10 ++
 3 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index ca1795467155..f838e1e71183 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -18,11 +18,185 @@ static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
 	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
 };
 
+/**
+ * cdns3_ep0_run_transfer - Do transfer on default endpoint hardware
+ * @priv_dev: extended gadget object
+ * @dma_addr: physical address where data is/will be stored
+ * @length: data length
+ * @erdy: set it to 1 when ERDY packet should be sent -
+ *        exit from flow control state
+ */
+static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
+				   dma_addr_t dma_addr,
+				   unsigned int length, int erdy)
+{
+	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
+
+	priv_dev->trb_ep0->buffer = TRB_BUFFER(dma_addr);
+	priv_dev->trb_ep0->length = TRB_LEN(length);
+	priv_dev->trb_ep0->control = TRB_CYCLE | TRB_IOC | TRB_TYPE(TRB_NORMAL);
+
+	cdns3_select_ep(priv_dev,
+			priv_dev->ep0_data_dir ? USB_DIR_IN : USB_DIR_OUT);
+
+	writel(EP_TRADDR_TRADDR(priv_dev->trb_ep0_dma), &regs->ep_traddr);
+
+	dev_dbg(&priv_dev->dev, "//Ding Dong ep0%s\n",
+		priv_dev->ep0_data_dir ? "IN" : "OUT");
+
+	/* TRB should be prepared before starting transfer */
+	wmb();
+	writel(EP_CMD_DRDY, &regs->ep_cmd);
+
+	if (erdy)
+		writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
+}
+
 static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
 {
 	//TODO: Implements this function
 }
 
+static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
+{
+	struct cdns3_endpoint *priv_ep;
+	struct usb_request *request;
+	struct usb_ep *ep;
+	int result = 0;
+
+	if (priv_dev->hw_configured_flag)
+		return;
+
+	writel(USB_CONF_CFGSET, &priv_dev->regs->usb_conf);
+	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
+
+	cdns3_set_register_bit(&priv_dev->regs->usb_conf,
+			       USB_CONF_U1EN | USB_CONF_U2EN);
+
+	/* wait until configuration set */
+	result = cdns3_handshake(&priv_dev->regs->usb_sts,
+				 USB_STS_CFGSTS_MASK, 1, 100);
+
+	priv_dev->hw_configured_flag = 1;
+	cdns3_enable_l1(priv_dev, 1);
+
+	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
+		if (ep->enabled) {
+			priv_ep = ep_to_cdns3_ep(ep);
+			request = cdns3_next_request(&priv_ep->request_list);
+			if (request)
+				cdns3_ep_run_transfer(priv_ep, request);
+		}
+	}
+}
+
+/**
+ * cdns3_gadget_ep0_enable
+ * Function shouldn't be called by gadget driver,
+ * endpoint 0 is allways active
+ */
+static int cdns3_gadget_ep0_enable(struct usb_ep *ep,
+				   const struct usb_endpoint_descriptor *desc)
+{
+	return -EINVAL;
+}
+
+/**
+ * cdns3_gadget_ep0_disable
+ * Function shouldn't be called by gadget driver,
+ * endpoint 0 is allways active
+ */
+static int cdns3_gadget_ep0_disable(struct usb_ep *ep)
+{
+	return -EINVAL;
+}
+
+/**
+ * cdns3_gadget_ep0_set_halt
+ * @ep: pointer to endpoint zero object
+ * @value: 1 for set stall, 0 for clear stall
+ *
+ * Returns 0
+ */
+static int cdns3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
+{
+	/* TODO */
+	return 0;
+}
+
+/**
+ * cdns3_gadget_ep0_queue Transfer data on endpoint zero
+ * @ep: pointer to endpoint zero object
+ * @request: pointer to request object
+ * @gfp_flags: gfp flags
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_gadget_ep0_queue(struct usb_ep *ep,
+				  struct usb_request *request,
+				  gfp_t gfp_flags)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	unsigned long flags;
+	int erdy_sent = 0;
+	int ret = 0;
+
+	dev_dbg(&priv_dev->dev, "Queue to Ep0%s L: %d\n",
+		priv_dev->ep0_data_dir ? "IN" : "OUT",
+		request->length);
+
+	/* send STATUS stage */
+	if (request->length == 0 && request->zero == 0) {
+		spin_lock_irqsave(&priv_dev->lock, flags);
+		cdns3_select_ep(priv_dev, 0x00);
+
+		erdy_sent = !priv_dev->hw_configured_flag;
+		cdns3_set_hw_configuration(priv_dev);
+
+		if (!erdy_sent)
+			writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL,
+			       &priv_dev->regs->ep_cmd);
+
+		cdns3_prepare_setup_packet(priv_dev);
+		request->actual = 0;
+		priv_dev->status_completion_no_call = true;
+		priv_dev->pending_status_request = request;
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+
+		/*
+		 * Since there is no completion interrupt for status stage,
+		 * it needs to call ->completion in software after
+		 * ep0_queue is back.
+		 */
+		queue_work(system_freezable_wq, &priv_dev->pending_status_wq);
+		return 0;
+	}
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	if (!list_empty(&priv_ep->request_list)) {
+		dev_err(&priv_dev->dev,
+			"can't handle multiple requests for ep0\n");
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		return -EOPNOTSUPP;
+	}
+
+	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
+					    priv_dev->ep0_data_dir);
+	if (ret) {
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		dev_err(&priv_dev->dev, "failed to map request\n");
+		return -EINVAL;
+	}
+
+	priv_dev->ep0_request = request;
+	list_add_tail(&request->list, &priv_ep->request_list);
+	cdns3_ep0_run_transfer(priv_dev, request->dma, request->length, 1);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+
+	return ret;
+}
+
 /**
  * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
  * @ep: endpoint object
@@ -41,6 +215,17 @@ int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
 	return 0;
 }
 
+const struct usb_ep_ops cdns3_gadget_ep0_ops = {
+	.enable = cdns3_gadget_ep0_enable,
+	.disable = cdns3_gadget_ep0_disable,
+	.alloc_request = cdns3_gadget_ep_alloc_request,
+	.free_request = cdns3_gadget_ep_free_request,
+	.queue = cdns3_gadget_ep0_queue,
+	.dequeue = cdns3_gadget_ep_dequeue,
+	.set_halt = cdns3_gadget_ep0_set_halt,
+	.set_wedge = cdns3_gadget_ep_set_wedge,
+};
+
 /**
  * cdns3_ep0_config - Configures default endpoint
  * @priv_dev: extended gadget object
@@ -106,8 +291,7 @@ int cdns3_init_ep0(struct cdns3_device *priv_dev)
 	sprintf(ep0->name, "ep0");
 
 	/* fill linux fields */
-	//TODO: implements cdns3_gadget_ep0_ops object
-	//ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
+	ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
 	ep0->endpoint.maxburst = 1;
 	usb_ep_set_maxpacket_limit(&ep0->endpoint, ENDPOINT0_MAX_PACKET_LIMIT);
 	ep0->endpoint.address = 0;
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index b08e0836f9a5..cd6023c04be9 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -178,6 +178,14 @@ static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags |= EP_STALL;
 }
 
+void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)
+{
+	if (enable)
+		writel(USB_CONF_L1EN, &priv_dev->regs->usb_conf);
+	else
+		writel(USB_CONF_L1DS, &priv_dev->regs->usb_conf);
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 3930613aadda..9732273f1b32 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1064,11 +1064,21 @@ struct cdns3_device {
 	struct usb_request		*pending_status_request;
 };
 
+int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
 int cdns3_init_ep0(struct cdns3_device *priv_dev);
 void cdns3_ep0_config(struct cdns3_device *priv_dev);
 void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
+void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable);
+struct usb_request *cdns3_next_request(struct list_head *list);
+int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
+			  struct usb_request *request);
 int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
 int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
+struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
+						  gfp_t gfp_flags);
+void cdns3_gadget_ep_free_request(struct usb_ep *ep,
+				  struct usb_request *request);
+int cdns3_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
 
 #endif /* __LINUX_CDNS3_GADGET */
-- 
2.17.1

