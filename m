Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47756C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB40A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tx9PdkR7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SMVyvaXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB40A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeKTBjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:39:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:42918 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729376AbeKTBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:39:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAJF2KPP023047;
        Mon, 19 Nov 2018 07:15:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=820CMI7kmyribWUvKdXCeTeIgSB3oYSoKceZ5Z+wYB0=;
 b=tx9PdkR7RczBrlrSIoyTjslUSmKFr5O/cHEPyk87tKnyh0+OicONvMQcCsdw+Gs1+O4+
 lee+Qonmw5cLalzR61zjmwI+629WpIISLQ1pDJuRImRPJaOoU2q86yCjjTv0kSGQsvsa
 73QPlnnw3xjzyH4g2LxspgPaKCFOXIuMjHzXoIrxDGoXlcqJ/NLdqNtDEd/CVwjTt5Hn
 0ZxGGl7rBW6V2eut2RKmYc4pHvqc+VMQGjrU+xgqafHSWzAf82kzSLLwbGvusIQq4zsX
 Q4sUTYcuJvzSgIboAocZgGy2rzwyjop/3LDPuICOKZ6Q6Y5E59FZdYW08gQV/rVQu9LH fw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0021.outbound.protection.outlook.com [216.32.180.21])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ntge1aust-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Nov 2018 07:15:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=820CMI7kmyribWUvKdXCeTeIgSB3oYSoKceZ5Z+wYB0=;
 b=SMVyvaXGlI78h3vqdjb01yO5wfuPjH6pfeWiEigSgtbI5WyrjSMUqD32l3UKyECxul2lcVuXGUaaEnPnRPtwJ/AwcaZsrHwaI59R9GGIEP6MfAhvYkB3ozMtZZTE3KuYYOwULmAEC8iAlmid1sdVWnx/7tORNX4PA9Vqecw3ViI=
Received: from SN4PR0701CA0007.namprd07.prod.outlook.com
 (2603:10b6:803:28::17) by BY1PR0701MB1862.namprd07.prod.outlook.com
 (2a01:111:e400:51ab::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.32; Mon, 19 Nov
 2018 15:15:11 +0000
Received: from BY2NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by SN4PR0701CA0007.outlook.office365.com
 (2603:10b6:803:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21 via Frontend
 Transport; Mon, 19 Nov 2018 15:15:11 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT040.mail.protection.outlook.com (10.152.100.177) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Mon, 19 Nov 2018 15:15:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAJFF4KZ031566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 19 Nov 2018 07:15:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 19 Nov 2018 16:15:07 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 19 Nov 2018 16:15:07 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wAJFF3Gh019670;
        Mon, 19 Nov 2018 15:15:03 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wAJFEx5a019581;
        Mon, 19 Nov 2018 15:14:59 GMT
From:   Damian Kos <dkos@cadence.com>
To:     Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        "Sandy Huang" <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Damian Kos <dkos@cadence.com>
Subject: [PATCH] drm/rockchip: fix for mailbox read validation.
Date:   Mon, 19 Nov 2018 15:14:14 +0000
Message-ID: <1542640463-18332-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(478600001)(126002)(486006)(5660300001)(246002)(105596002)(106466001)(87636003)(2906002)(51416003)(15650500001)(26826003)(50466002)(2616005)(48376002)(426003)(476003)(47776003)(336012)(7636002)(305945005)(26005)(14444005)(186003)(1857600001)(2201001)(16586007)(110136005)(86362001)(316002)(50226002)(8936002)(36756003)(8676002)(6666004)(356004)(107886003)(42186006)(4326008)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1862;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT040;1:VQ+pDj4YNaLl6k/VZ13nQ9whFc9Qsr55UJ8OBIZjBjYIKKJOgDXNnnsPX3TNz7lnE+2E3mNblGkY6O4kSlJqElZMV58wM6HajJ0GOcyWOrZAP2FO9Zge1KoNSrdUVAHg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a76c416-b4d5-44fa-1eaf-08d64e31cc50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY1PR0701MB1862;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1862;3:G/AdunIhTvJL3q/fIRSQJyDPA2+i72rizsd8fNbCoU1i61gEQMTvrqeMQkitucPM1gbnNTyFNwI9dhfWFn2RNwOv+pCYxvJ33Zyy28Y8aKq66plxNiAvZDvV4TM/t3Rr1HiUT9jpmAASNsCOsJe/CSJYVbgDVQNlhwi2U81t0h+fPYj2bT6qy+MOrszRVMh/Lu/ZR4YBNy88BdX/5spbJNo5jkCgr/UYZczwkZh5iLTNrQxgbQK8ZeDb9IPjKI3HYgi5orQ1BIEEnw7lFu7SMjR9ZM32ThCcyO79RCSSgMj3OUlyYX18cCjKm9yARC+FauBX+NEZHygm5nXV5nNzpkzjL16Sccaglyi9CcBj3ds=;25:ZXQd8NPVYpjslmtiZIeITritx2kkWYOt1rwGS1st1fxTgJOorZ+gbFHmWuaDXtsoFtj2w0muCNVglckatxnz3suQx+70saIIcDnBuHu7CbHC/g4lROb9/MXxh0jI5FUbbq9qu/5x/HMnrX3+2qmdbVLdZf+Hw763N3Wer9JnzHXG3/u2nIVs49DzSjtiHDQZKaacseS/nPmyYqNRlkb/tizdK1U1kzqQH8C4u1F0epTbZXJ33cIWh7f2f4S6sL21iU8ZzswvZEsLZnQx7jHAPXdQrQ4Qmb88CSA56PksS6+Gu0gzCAMR9bD44VIw1wdjxCLOhaXjvxMVo9B5baMoSK77KZc7lBRQKJZU60NvM6s=
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1862:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1862;31:N5i9hWbvxwmNYvmDdwGm1Bh/JwS2aOiUwUdI0d1cbaO3S1HiE+B21OLx8TpgEIixdE3AU20Og1RxIyeE70Qla5kL+NNx9L+ryW+dRL1KTLetz3hajvLB9o8jsHREU81kYJ46o65tVSXnWJnaZ7NghUHKUW4AVCwdz7WmhFxEiEewUAmxfHBP81gsD+hM7aOvWQ9mnMCSNHkY7Nejt4kXUYN5HEZliow6uzNuQOsWcM4=;20:HrXx2MIFESHYtEWmK93oUdPPm4PjRQLtd7293o8xqcLp75XO9GJpxbif5xxzbAphI2dOSO8Efw5blbHQmMzuCzp0RzPPUtbT0iYkOrHyoKZbeCJmoBKz+uf0ZVyUSzmoli52l325AquX/nw2k22qh8ll/nGn7nFJTd9/uqpWShvlUUe+YCEeZ4tLg+L52zFfpw5ipHvH0sfUjQf14lmxUlHaytN5jLsHoZuSJ6nX1idLH88ym6rCK0Bl4IDmHmNV+ofr32e319r3IyMAgkpCQgkaAy8QZkGxpzztqw1AcvBkjLXJQhz0Aor14dHb1DEwxxVY6t/x+VoEE6EJ23+eaga9HhEjCcB/wAsmIWS+kuzVcTFyxf/nMW06Cy7VT1QLyLeOl9R8HZc04dRJ9r8jImIhWSZvBOrDtjJVg8LmInTkA83vbQ3D+HDBsAd2XgOkdX6mkPF0ZgWAikFgmC/VS686FcE8MO5jeJJcrtdDo42iBwtqpyK9A511mJ9s5BlY
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1862D3DC6855EBEB48CC617ECDD80@BY1PR0701MB1862.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1862;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1862;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1862;4:0DfmxIaTKKqEfStxz8EvMmpeQjz1llVv+JJjocyx9LzqjhL0qlxZgBX9DPSqcEL1U18gQpwqKztVbMHPGYdWclCXz6Cgoq8FZ6vb14pN3kIjbMis988EDLvH6s8HUCPCzmLF/mSqMXKsUuKazUSL1xeRXugoRXp5oI0ApCSNw1Vfr5EcvOEXH8RN5sW/n8b+x+gjn8kHs5oCp+KdCHLUK//GJ27K0MhWW0CedlvDTEU1f3eaZFcPYQDDrDW8jxRsl34RvQuUlZAJ5JPnV164LdGKPb+Hkw6Qz3ljGEuKCvnYiSUyBOMl4jE5jxxAmo51
X-Forefront-PRVS: 08617F610C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1862;23:rsNtpfFZhfLU75YeH2B6rWENytfLaZLNWazfCYd?=
 =?us-ascii?Q?iMdQcRU9tP1Zzc+4QE8mGa3wDBSe5X6sVHJjt6hFjthX7yvaewijy+Y4T4Cf?=
 =?us-ascii?Q?OHcWvjLiOeV6vZzrcNl8XDGf0OLiqA+FtXz3JFXYZMMIUCpZWbUFoK60t1ov?=
 =?us-ascii?Q?dfGt3sHRK/yXKXFfr3RgMjoTh65G2v87xAISptzKLTHUnglAFo6PuftF+wWA?=
 =?us-ascii?Q?8+N36fuFww3bgHT5P4lvHlFq9CIBASwtZHU4HJVG3r3HIDv+jbh8LIQt43/Q?=
 =?us-ascii?Q?GEHsuEglKjOF9/J4fXq5r8VvVXMVv9A3On/pNIi9NUwPFufPBeGXyh7h85Jn?=
 =?us-ascii?Q?aQvzqs3vhXf3t+nQOr6r/HO1l4ecVbm/2uLj6ly5zG0q/kka9p/hrvDlkWVc?=
 =?us-ascii?Q?bmEsFyy6/1acmWXmclMJwj6aQ3fksZLK9zFHFLeR4O2biHBpZ7DEcmikBuLp?=
 =?us-ascii?Q?5vG/3OIFEMturDPa+LGySeQmUWLiXuhBhii93QbXWRJL2DRr3yjcmyNPIoWz?=
 =?us-ascii?Q?xn0mbqRuS+S16JIV1/O6uEuejqLge/XUOfJDXVoUblIDlwg7jCt8cMpZd/h0?=
 =?us-ascii?Q?90pBPejlZ7BlNv08ShikOXx1WShKFFtEkyhFp4QbNQBfqBbzfbrPhmD2NDyD?=
 =?us-ascii?Q?c5B5nZINxr35hqVYmBxEno5xvxh1bhUaIyNA9soOIP+mSjk2xKhbeMIqL/vO?=
 =?us-ascii?Q?/4kuBpNvD5FMbpHHToAXlnpJZMFE8K26iy9ECjxR6XFMuKwKkFp5nH4YagEy?=
 =?us-ascii?Q?uPrFU1kiUly5Z3tALw5b+x14uXP1DhYn2cgMqF9Sc367ppo7YTyq6xXOAEzY?=
 =?us-ascii?Q?uVTnR5stqX7iKuHXuT/8k6iCP2M5AIjRtXpAsap0cZw2EpYhZDTYfjLgLXR9?=
 =?us-ascii?Q?YZEjyQctZb7c/bw+m2h1T+1HeURasEfZD4866nxhUpX98OdoV96gwYFAnReV?=
 =?us-ascii?Q?JHKC74h0cYZwBx6kN44K3MH9MWn7CYrfgq3d/e54XmixKgMuAfYwW70qnyoT?=
 =?us-ascii?Q?uOH96szaPxG/tLimUwliJW7hWtCCxxqF1lp3GR+ME13sNnUzDEw85WB6leap?=
 =?us-ascii?Q?UmwX811eYvRQTmLb+mTexYV9ksTK2hHVj32x1KXZdTtD3a6k75g=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5iiDbFfJFsn2Pwl1smYDTY2ncPtsICx1wgj8iGfGL7ZgKWlC/1S2pdYnysuHEnmEC3xGgxXPJ0Ap9tLZgN+giDmjTPo/j9SbJvsdlEhZSk9XVWgwMa1DE9IZtC9AvIXSxAePXrGmexMQ66wV3dnpa7cKPzDVuvCr12zNiskR6f9mhQ18p9x2UrWyw2Rc7pitiJOKJQai05GrBJpHRJZIV0fTakJNiY80XN/Hgv3d8APlDtHqbDrVEXYaRmrv2qmusXX6Js2BM1HCDRJ0bNNiRkbPT3UKDlQFTzdMnB/oOGbAavtIoxIcAQh/6ua6XrnLXEYH/i29lBnI1tUteNTeZgYDRqf/Q5KLb9O7iOGxwjQ=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1862;6:HymozhNC8QOoBWGQdma0q6JftlYH9JC+pVUwctxm1JPsW0aCk++b7I/0zgZRZstm0rSmBDuYG3ePXz3pwAtW9sBQpQQFyj+vd5hKuJ90CqxlsLvyDpptfx5w1D2zSJBFyNnW4kToKviC1GF6XuoaREqnjoCgo5y3yM8+U0D69XEEtN0LLmPmH7tH5bpbV4GD16Aa89Idr8MFxeGoMovl5ReLj4XbGLUqNGvPyCd9xxRLWM6lOUKNp6/5WoJRd/qmVw4zXDG6xvMg5wi0dHDUmGuHp39y3r2jShzowaiXvMkj94fabbXprduMeySR91N/MDyrFeO6xN4X7e0Ve3PKOYPhXO2DaqLbZd3ChTcZVl+z3h1pBl2RNKgopeJwFc9Xd9wh8/ej8LLyVl+o1FEcrZjZqYgqLZMAgOrzI/+m7kT3uvPl+B5Orp9vYOOv0i3FFefLdgErzJ8i1Vqh47Zq1g==;5:4Nphe6K+v1/yo6/nE1qpa3JN/qONNyryQhVxIm4h0kSvFx0W8SJr/GMdGOKLCGUpB06J9R04mtGVf6Chd0KkcBA96AchVjRd/J01ifXFO7AS3kn99PouNabpg9ZzlrozIz/OSq+uBPtC696Dc7NZSkMWBYfWNNazgzmYosqecJQ=;7:8g1lGtsFU5EUm1llu0Tk85/4hLWwpxvwYnUe2hcJ6dx5vPBjf9ZKQG19dYli7NJEdhKIXalZcfVHPtusYqZTcyiGM+NtpDMpkyDxX4AuRbekn/RbVjnfSlkSiUem42RuDj5bISXbiJbTt5E5nNViRg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1862;20:nJkqY8P8SkKmOFzJ2mAZVixT7GuTrlCPnRcxfZwQI2zanMSNt4LwoJW3cmWE0FsBA2wh4Qd9bV/OSZW8p/pgACkc6fiXygZEsQkZUs3YfBhP0ftQlzd8YlCNsF2hwy9432CM/vulVe4uWaXNHw+zUp1XO9akCrZamiGgsEfWKfboyuy49BGfiv40AwcEq/Jw3JtvT69H+eLLVK6EnYD5q5QpMr/KVsvtHaMUrDmPEyHUetop2mqbQWxDIRQrTJ80
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2018 15:15:07.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a76c416-b4d5-44fa-1eaf-08d64e31cc50
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1862
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=617 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the same fix as in
commit fa68d4f8476b ("drm/rockchip: fix for mailbox read size")
but for cdn_dp_mailbox_validate_receive function.

See patchwork.kernel.org/patch/10671981/ for details.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 5a485489a1e2..6c8b14fb1d2f 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -113,7 +113,7 @@ static int cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
 
 static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 					   u8 module_id, u8 opcode,
-					   u8 req_size)
+					   u16 req_size)
 {
 	u32 mbox_size, i;
 	u8 header[4];
-- 
2.17.1

