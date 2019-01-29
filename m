Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478222184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MAUKMtPW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hlfxMFF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfA2QJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:09:23 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49180 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfA2QJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:09:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TG7mSY013026;
        Tue, 29 Jan 2019 08:08:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=KulJi7GCj/fHsHc3tTwCYZQ+mmJsFWA70UCX7y29KUg=;
 b=MAUKMtPWF5wyas1SXFKljkBw3XP1qVqwUhz/4052GpVDyv/qVL6R5bgaSIUwSOTXBzfe
 cPZowyC/1XxbZb4WjxxQ4i1nD3mn95g0ihTJrv8ACIZxu7cvaY0YXVc+UnyQXCVRDIRi
 +lfi2EIhcD9gr7kIEksEY1LCyj929ZMpilbK3oI28ijhO5Yi1x3vWCeNiLwdqGSWvuSU
 R5jp4Ri+QXrCmXTD/X3BJYh8kbcm+/JkTBnpqrAN9lnYGKU6eOGfUp05/FpTzC4OsYoW
 pfwwuKnPM/Y44ORo/FLAauwFpD1WI0hV2cBtgu9ImM3X3O4cMNDFpjmWSuY3FGy3Rj31 gg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2q8n0049ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jan 2019 08:08:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KulJi7GCj/fHsHc3tTwCYZQ+mmJsFWA70UCX7y29KUg=;
 b=hlfxMFF9F3CcE53pj7MKQgnI20kA3NzJy/rvSzWFFFEd+337zupSQiW/qlmp6gkp5cKoXm47uSU+2e1M4LcVibxxuLsuOSp2zletl+C+l8HNDDBRqupjB9ii6PyOsGy1jmUBj0gcT/JAsH5mDcrSJTHZ4MBqhFRlsf1GgS2HWJw=
Received: from CY1PR07CA0034.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::44) by MWHPR07MB3104.namprd07.prod.outlook.com
 (2603:10b6:300:de::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17; Tue, 29 Jan
 2019 16:08:29 +0000
Received: from BY2NAM05FT031.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::204) by CY1PR07CA0034.outlook.office365.com
 (2a01:111:e400:c60a::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Tue, 29 Jan 2019 16:08:29 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT031.mail.protection.outlook.com (10.152.100.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 29 Jan 2019 16:08:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x0TG8Plo017818
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Jan 2019 08:08:26 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Jan 2019 17:08:24 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Jan 2019 17:08:23 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0TG8NX9011329;
        Tue, 29 Jan 2019 16:08:23 GMT
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0TG8NjO011326;
        Tue, 29 Jan 2019 16:08:23 GMT
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>, Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH 1/2] mtd: nand: Add Cadence NAND controller driver
Date:   Tue, 29 Jan 2019 16:07:43 +0000
Message-ID: <20190129160743.9103-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190129160337.24350-1-piotrs@cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(43544003)(36092001)(189003)(199004)(476003)(11346002)(86362001)(47776003)(30864003)(6916009)(76176011)(107886003)(1076003)(7416002)(39060400002)(478600001)(106466001)(2906002)(486006)(5024004)(126002)(6666004)(26826003)(356004)(2616005)(87636003)(51416003)(36756003)(4326008)(14444005)(19627235002)(50226002)(26005)(42186006)(8936002)(105596002)(305945005)(16586007)(8676002)(7636002)(316002)(446003)(186003)(246002)(336012)(2351001)(50466002)(54906003)(53946003)(48376002)(426003)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3104;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT031;1:tL1hODm6nl7wMBQNSXqcFdpeuVlC0AkwugAbwQ333UX2yxvDE5RtsJtefHp6nK69MkNweNayVhzHZxahBEZ5i8W6c0QJBamBBUjJ/z979rUJlJNygKGLUYGx+KFG1jJh7mTiqmFO22yYtpVMcCDlXw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb65cd55-0048-4ea7-7e90-08d6860401d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:MWHPR07MB3104;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3104;3:Zz8v2INDRnP88gfWTJFXxwciF6NZFkpVVQtJGNGmsJQ6jTrZrPSSWzXLmn6bHwASo8XIHTJM8VF4tD+n1o0qd4lpEDLKqIsPP+H6hItIqfgCaxT56tRYydaZTRUai5wlImb6OgbmY4GFhWrjcobyL7klJw2uxe0DuZuRs9T1qjSSH29e4DzPrq7H8mOvMgx6k4cj0z/gW0G/0WhrFaOBcXBFmh97K2kDkB1qAwipTjTzR9GkGj3nRNOCPsaFNNAOWT+Z6vOWDxCsJ7mOUPdk9Owz0FHxRZNJvQby3I+fMQCleWOBB0FnR+M4snGBY/f+1GD3TiKHxYGubhSHD4PRhWimvEZI09MdGz9ZrfUEUWofgPC5Z3gPOwXoFRYmm9ri;25:ZgiwTmqqN0L54/zKr48GjUCdQ3XkqMlJqt6ioZwLVKu+1JHti55FxmSrR1fsG1Q+tMLIpKIz+z/4mnEM3XTIt0xfsOJjUha5Fe8dRzpMcgTiDPf28A2+XJViSmdWDccp3kFNJSNEUSclSdq5VZtrTdXsOfCYpapyfXxl2H8PWNiHvq3U+xZZmZIkRbd0r2znClru2/7Ri6amRhzRwVL5lRW6iiwisXQQi8lXyQhLneCOwp5xye6SwG9wR7+e7CwDu/P/efeQcTiN7Xco9mXxsQMUV4wy8UwRTJiGjjuhSOIJRxJuqN+m33CEXxDVunB/HvM3hBLHXEKOC4ZSrrZfIw==
X-MS-TrafficTypeDiagnostic: MWHPR07MB3104:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3104;31:m/WBsR7RfOKnopBsVyfuw9uf69itDwGN2u1QAOz7lvzsR6Qk006JfGUuMe9tYoVfMUpPFP+Y1R4+Qxo1iSG66FapcceWJsWpvOlYbs3b3bKIxdwXhqXsAc/wmCp6lHfZAayeA/ErJ9NoTevXu+eWhzf1/dYPYyTwgB5RpUdiCeadrYgkChXmMrtuN2vldfgdSMR2E117XxZ0ZkV04l9ugewiAEKu2iD8QZiwM2ElxHY=;20:Z7YLUBdpn5OiLbCo6M46lMVKpkzBVnFZKOP8lyOhbnaF37ozhIhtDxj0xaYpVAmvpHcrOStABjoMFuzhXfDE2cEfW8C6X2bMopLPglWfCD33bE0Wzfv7ud28GSQccXjbOda9BqOaYi6GCbY6AfZ/ZTi60nc+nNEc5jL70C+x46RPg5BMXcV//qyH732x5HKkTo/N+ycqa8k+vjH6Naobq6v2ZlS18wDHtJp5uiZNnB5d4B0YyN2AHDdB3pg7wgQeoMBY8iZqptExP50zDZ+pmU6RP0GzBTahe+ri2jlnEbnBktaYMl7eWq2nILh9Zx7hOv68NUdE2bY3OzE85rcnVc7pEh/4bSY6ouMk2lfjy7+Z/KSZuhjNJhJPCCaSclaVb9cxdPrZ1sDxY8SB4L7Q360dp5TAIOebC4oocJPjz+lnA8Z+EIUXlO/uKaaztuQVlPz7LsifLuCth9KHE8fkBOhHMQFvtNLUUu64vCKoTFuY68JY/eCgxeAD6CxonU8m
X-Microsoft-Antispam-PRVS: <MWHPR07MB31048C84C1B1B0CA9BFBEE3ADD970@MWHPR07MB3104.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3104;4:B7Vi2dBVAt8ro2g2NX+fRhEjf4ausa6lC6DFiWMNQfrJo71u6AIIKPMQdu5a1544TEVY2O+aE6Kh96llN7ulTgSYUIVEX5m9iVhfvBpK19lcVuQdjaYVtvQL953KCgCYzXt2CCEwt3tAbfB+jj3spAoyiNYUNZbV01qY3FwrEMCXgmES7p0abQaVcW23W1F53JV+5YbaaN+LqYb9C5V9YVD2kpc4FBdufkjbOZpTXk14BTHOuSZGMAogdFnU6Hjd6laZZcPLg6wM5ONocGvVIMA+6wCncJlRYm9gnZhK780=
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3104;23:LSa3urSygW4TsNBK9U+rHXPebeObmJZlOxi6jGCg0?=
 =?us-ascii?Q?V0+NQy7wrnEKaI8k7IphOJwKcOmK5drWPBz4SmC6ZFjMKEyJExIlkTvenojC?=
 =?us-ascii?Q?/LpefIjR98cWCeOklJvZMjz6ekucBx6MuZ0iBBeSQ4dIIfHqDb5fVpOtZz5F?=
 =?us-ascii?Q?bs9atFGKtp7/v8pLu/Be13RmPRkiNQle6Gpf+gEOpmoByK8V09tMT4KdtOS9?=
 =?us-ascii?Q?GdLLHgRlfaw2CCuf8CjUsZbaCp9jBL/+Ow3j1JSRjYuqh9/iOhhlg6IDSbEi?=
 =?us-ascii?Q?wFArJ1qwX0XPKzJIkHC3YPazh4MVdcgKI2jc8muU4ZAEdr5A7yO+sHLeozqC?=
 =?us-ascii?Q?hXDUT5UWI4q1Vy2GPTneiEG2VQoQmY3Q85xAyKV0DmiG2j2lx/MfAjJAGyg6?=
 =?us-ascii?Q?6Jy7Cex81m8OCdJbawmP60qe1M7KhxfA7MbZPqobxP+MRwcQSu2diDAGLS6R?=
 =?us-ascii?Q?rfTZevflxPZutqwjA0IgkPVhYxpvmFwLFO5/HPjCsY05RNW3AvOHszKYsZb4?=
 =?us-ascii?Q?coZYr8dlJVAVhrmjcFERjPx7HRU5wAz0EpCuB4Y0dRcC3O6UQihxdyjS7Zdp?=
 =?us-ascii?Q?vW0l6uzCN+iy9lQYN6on65afK24OVApy9+PqI25eLtsD+LijaU82fj+pXwZF?=
 =?us-ascii?Q?R0gSvyaz1+ALoVrhix+PIRnV5HYBpED0B5NDQSNtgW6/MUAwRTUMQnE0ZAOr?=
 =?us-ascii?Q?LPLWMi66Et6HlRYXUwnEDlFd1Y4iFOCmApTokl96PFEdb1FF+1Y/lnbdmCcr?=
 =?us-ascii?Q?uTFOHRukH1MwZwsD62IDPGKs0Q87e7DrdlciY6Ga3p7ioUFKDx+bZKMEAOZ+?=
 =?us-ascii?Q?xoseJzkLFUQyZsdX3UhQ6XZNOzmZC1bFkgH8YjWZ+pNWau1zBdOVBMdwYyX7?=
 =?us-ascii?Q?xufrZRakWS1uDJVeDMhcGAK1lt5xfvjSFgdcEVKR7/wXKqrIGnmVEYqeKFuF?=
 =?us-ascii?Q?ZonyBvsz3ivEuvJK1A6+yKpm7GBor9tb0rO7AxtOC7zFTK+4lpY7h1mLmUL6?=
 =?us-ascii?Q?3fizetLD0MWBGZ+TmlNOQO39DilFdAZP9QvB2dpnvA6ilTW7x9VrRuPlF5UU?=
 =?us-ascii?Q?tBcLarGqTLxr0+0GOis4RkHY7noojzO4isKJILirniiV2rSfydiD9gNgFgja?=
 =?us-ascii?Q?dJI5jmAH27IxqJsWQ9vNKxAyzAcv2qnyDuFulgz8pCr4n24Ih/ZXtOzD/zKX?=
 =?us-ascii?Q?2kkB/+O9+l9GReJwop7CP1zigIixTW+XjssK0OAg5oo3gVC++Si5f8JqqBl9?=
 =?us-ascii?Q?sTpcS5eyGPXYb3WV5ABBzIYA4myj8vaoDvylvD7?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WIPwxaqYDfHUr/yukNPdmjbn/ZLvju0rPb2QYgnz5YrrY3iFpn1kMCmlZyJMu0Yt1LF6vs472oeyj5/f0nFuIqMxqcTtF4gAVP3nmZxfuCT/Zy3+ZNCGB0ruincM3AzPMieyCxGSINJazWyqeo5fseOG0fKBwT6hhILCxvo6LPfRFR99tNtuKthahHZsyotnl9IJh0e+bssNbFsRthFXNH6GgUl7xiOd5ygzHZcspBxPISl1Ilxg3Lt/1rrMeCWAic2AVA6sFBOx2Wwx6+fEFt2nqti+tDfebD3WKgrfRulOj6JfIgVBNGw+KDGYJk+nOK2b91AXSBGclKzNzIj2IpX/VGNlNYbxOnF1Na0hvGPExeNJbr40uofa6tVh4CONa+TsHnRu88IHAbYgQJ3YxSKlCn4l1YNm4fLSBuBSAZQ=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3104;6:aAjBVI0wf7c/TL7qODozNk0LbqG8XsGzM5Ab9Kj/b82h7I9c+4oP/vTCH2ZWuM1ybKrrY+7ElBAJm0u9fEjvyNjlxLqynUwfvPJQzCVWvF6cdyb5pH/xdpgDsX6XrCDqyWNN9vs5PTP0pSuHx1nLXcwMMRW+pKX6r4lswhmOSLSX0CC87Fx0nRZtu11JqYzMIAY5bEDwZpBziHq5kvoLcCEa0ww060JOHND+6KREvSwFjN7ZXzWAlF8RPs6HfVC7mOhkXN7xnfuhsYbkYEz72pkN9HzzcoV/28tkNL0ctfHstPYlZFz7Fg4FzHz8CDRDUOcQmc3D9xWC3B/lMoHcnSnwDJTPN2TLg8h9OpQrBN6sguthhCFqrenheVcltyitJLqL0e5YbaIIBbgd8gBYU3vyZ4VUwxmiF+cK4mYi2c35WZL4F57MjBFzmK7fGpTeMWjJ3cTA3wmZPKX2pQefZw==;5:BiXOQXpDiP8DQR5x4KwkL6UVgMVYtyifJATIkUTkJbKj6to/Z2QQBc4zC4DWvshacPRkxshEfu5pLZx9WLqCbBtNG8o05BUEiPZ63gvJOpj7cEepDvPwnAg33C41uFMRu9/b/TaDNcz14xoa3r/H8CIXEPLgqJ3uwl0JI115M+zfRSNjJKTC1XCxBRLlZEdSWY5XlXfawS+8MNAz/DVYuA==;7:0GImEe5xII2Y+/JgETuiRTXNfP7X/0DQjfqZ9BN3qCAVNIHfrOrdA7grv0g33DnElsaFj/oSBjrFgAiOT1MYf91bYwCTPn3IIGx6M6wsQhV9jtvl7GpevZ1tyh46vbN5s5+NAxMoV7FTWAR5Ac4wuw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3104;20:8hW+qkSuKOB0Qh5/mo7omM3VUbbHlNuNcghyhymxn1nf1eiuG4xf38C2iEoRm9qPjLchlCNXxm7DHOwpmNbJCs9dVfyH8qmwdfPrVLcO4ZAekRs13bqGRPwghVIrzvDkiHdbrnav/macb6lFQOcBq2KleFPW5d2kKU/ly8KtrRmJiRup+92SZzmKT26HsWYNuJD1MkJ1eun+TS8JwhPopN3gWY3GU4nN+6rGJwAGdrgi9PlGK6TfBfZ2RubebdwF
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 16:08:28.7373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb65cd55-0048-4ea7-7e90-08d6860401d5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3104
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver for Cadence HPNFC NAND controller.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mtd/nand/raw/Kconfig        |    8 +
 drivers/mtd/nand/raw/Makefile       |    1 +
 drivers/mtd/nand/raw/cadence_nand.c | 2655 +++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/cadence_nand.h |  631 +++++++++
 4 files changed, 3295 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
 create mode 100644 drivers/mtd/nand/raw/cadence_nand.h

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 1a55d3e3d4c5..742dcc947203 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -541,4 +541,12 @@ config MTD_NAND_TEGRA
 	  is supported. Extra OOB bytes when using HW ECC are currently
 	  not supported.
 
+config MTD_NAND_CADENCE
+	tristate "Support Cadence NAND (HPNFC) controller"
+	depends on OF
+	help
+	  Enable the driver for NAND flash on platforms using a Cadence NAND
+	  controller.
+
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b349054..9c1301164996 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
+obj-$(CONFIG_MTD_NAND_CADENCE)		+= cadence_nand.o
 
 nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_onfi.o
diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
new file mode 100644
index 000000000000..c941e702d325
--- /dev/null
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -0,0 +1,2655 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cadence NAND flash controller driver
+ *
+ * Copyright (C) 2019 Cadence
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include "cadence_nand.h"
+
+MODULE_LICENSE("GPL v2");
+#define CADENCE_NAND_NAME    "cadence_nand"
+
+#define MAX_OOB_SIZE_PER_SECTOR	32
+#define MAX_ADDRESS_CYC		6
+#define MAX_DATA_SIZE		0xFFFC
+
+static int cadence_nand_wait_for_thread(struct cdns_nand_info *cdns_nand,
+					int8_t thread);
+static int cadence_nand_wait_for_idle(struct cdns_nand_info *cdns_nand);
+static int cadence_nand_cmd(struct nand_chip *chip,
+			    const struct nand_subop *subop);
+static int cadence_nand_waitrdy(struct nand_chip *chip,
+				const struct nand_subop *subop);
+
+static const struct nand_op_parser cadence_nand_op_parser = NAND_OP_PARSER(
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd,
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd,
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd,
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_waitrdy,
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
+	);
+
+static inline struct cdns_nand_info *mtd_cdns_nand_info(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct cdns_nand_info, chip);
+}
+
+static inline struct
+cdns_nand_info *chip_to_cdns_nand_info(struct nand_chip *chip)
+{
+	return container_of(chip, struct cdns_nand_info, chip);
+}
+
+static inline bool
+cadence_nand_dma_buf_ok(struct cdns_nand_info *cdns_nand, const void *buf,
+			u32 buf_len)
+{
+	u8 data_dma_width = cdns_nand->caps.data_dma_width;
+
+	return buf && virt_addr_valid(buf) &&
+		likely(IS_ALIGNED((uintptr_t)buf, data_dma_width)) &&
+		likely(IS_ALIGNED(buf_len, data_dma_width));
+}
+
+static int cadence_nand_set_ecc_enable(struct cdns_nand_info *cdns_nand,
+				       bool enable)
+{
+	u32 reg;
+
+	if (cadence_nand_wait_for_idle(cdns_nand)) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
+
+	if (enable)
+		reg |= ECC_CONFIG_0_ECC_EN;
+	else
+		reg &= ~ECC_CONFIG_0_ECC_EN;
+
+	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
+
+	return 0;
+}
+
+static int cadence_nand_set_ecc_strength(struct cdns_nand_info *cdns_nand,
+					 u8 strength)
+{
+	u32 reg;
+	u8 i, corr_str_idx = 0;
+
+	if (cadence_nand_wait_for_idle(cdns_nand)) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return -ETIMEDOUT;
+	}
+
+	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
+		if (cdns_nand->ecc_strengths[i] == strength) {
+			corr_str_idx = i;
+			break;
+		}
+	}
+
+	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
+	reg &= ~ECC_CONFIG_0_CORR_STR;
+	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
+	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
+
+	return 0;
+}
+
+static int cadence_nand_set_skip_marker_val(struct cdns_nand_info *cdns_nand,
+					    u16 marker_value)
+{
+	u32 reg = 0;
+
+	if (cadence_nand_wait_for_idle(cdns_nand)) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(cdns_nand->reg + SKIP_BYTES_CONF);
+	reg &= ~SKIP_BYTES_MARKER_VALUE;
+	reg |= FIELD_PREP(SKIP_BYTES_MARKER_VALUE,
+		    marker_value);
+
+	writel(reg, cdns_nand->reg + SKIP_BYTES_CONF);
+
+	return 0;
+}
+
+static int cadence_nand_set_skip_bytes_conf(struct cdns_nand_info *cdns_nand,
+					    u8 num_of_bytes,
+					    u32 offset_value,
+					    int enable)
+{
+	u32 reg = 0;
+	u32 skip_bytes_offset = 0;
+
+	if (cadence_nand_wait_for_idle(cdns_nand)) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return -ETIMEDOUT;
+	}
+
+	if (!enable) {
+		num_of_bytes = 0;
+		offset_value = 0;
+	}
+
+	reg = readl(cdns_nand->reg + SKIP_BYTES_CONF);
+	reg &= ~SKIP_BYTES_NUM_OF_BYTES;
+	reg |= FIELD_PREP(SKIP_BYTES_NUM_OF_BYTES,
+		    num_of_bytes);
+	skip_bytes_offset = FIELD_PREP(SKIP_BYTES_OFFSET_VALUE,
+				       offset_value);
+
+	writel(reg, cdns_nand->reg + SKIP_BYTES_CONF);
+	writel(skip_bytes_offset, cdns_nand->reg + SKIP_BYTES_OFFSET);
+
+	return 0;
+}
+
+static int cadence_nand_set_erase_detection(struct cdns_nand_info *cdns_nand,
+					    bool enable,
+					    u8 bitflips_threshold)
+{
+	u32 reg;
+
+	if (cadence_nand_wait_for_idle(cdns_nand)) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
+
+	if (enable)
+		reg |= ECC_CONFIG_0_ERASE_DET_EN;
+	else
+		reg &= ~ECC_CONFIG_0_ERASE_DET_EN;
+
+	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
+
+	writel(bitflips_threshold, cdns_nand->reg + ECC_CONFIG_1);
+
+	return 0;
+}
+
+static int cadence_nand_set_access_width(struct cdns_nand_info *cdns_nand,
+					 u8 access_width)
+{
+	u32 reg;
+	int status;
+
+	status = cadence_nand_wait_for_idle(cdns_nand);
+	if (status) {
+		dev_err(cdns_nand->dev, "Error. Controller is busy");
+		return status;
+	}
+
+	reg = readl(cdns_nand->reg + COMMON_SET);
+
+	if (access_width == 8)
+		reg &= ~COMMON_SET_DEVICE_16BIT;
+	else
+		reg |= COMMON_SET_DEVICE_16BIT;
+	writel(reg, cdns_nand->reg + COMMON_SET);
+
+	return 0;
+}
+
+static void
+cadence_nand_clear_interrupt(struct cdns_nand_info *cdns_nand,
+			     struct cadence_nand_irq_status *irq_status)
+{
+	writel(irq_status->status, cdns_nand->reg + INTR_STATUS);
+	writel(irq_status->trd_status, cdns_nand->reg + TRD_COMP_INT_STATUS);
+	writel(irq_status->trd_error, cdns_nand->reg + TRD_ERR_INT_STATUS);
+}
+
+static void
+cadence_nand_read_int_status(struct cdns_nand_info *cdns_nand,
+			     struct cadence_nand_irq_status *irq_status)
+{
+	irq_status->status = readl(cdns_nand->reg + INTR_STATUS);
+	irq_status->trd_status = readl(cdns_nand->reg
+					 + TRD_COMP_INT_STATUS);
+	irq_status->trd_error = readl(cdns_nand->reg + TRD_ERR_INT_STATUS);
+}
+
+static inline u32 irq_detected(struct cdns_nand_info *cdns_nand,
+			       struct cadence_nand_irq_status *irq_status)
+{
+	cadence_nand_read_int_status(cdns_nand, irq_status);
+
+	return irq_status->status || irq_status->trd_status ||
+		irq_status->trd_error;
+}
+
+static void cadence_nand_reset_irq(struct cdns_nand_info *cdns_nand)
+{
+	spin_lock(&cdns_nand->irq_lock);
+	memset(&cdns_nand->irq_status, 0, sizeof(cdns_nand->irq_status));
+	memset(&cdns_nand->irq_mask, 0, sizeof(cdns_nand->irq_mask));
+	spin_unlock(&cdns_nand->irq_lock);
+}
+
+/*
+ * This is the interrupt service routine. It handles all interrupts
+ * sent to this device.
+ */
+static irqreturn_t cadence_nand_isr(int irq, void *dev_id)
+{
+	struct cdns_nand_info *cdns_nand = dev_id;
+	struct cadence_nand_irq_status irq_status;
+	irqreturn_t result = IRQ_NONE;
+
+	spin_lock(&cdns_nand->irq_lock);
+
+	if (irq_detected(cdns_nand, &irq_status)) {
+		/* handle interrupt */
+		/* first acknowledge it */
+		cadence_nand_clear_interrupt(cdns_nand, &irq_status);
+		/* store the status in the device context for someone to read */
+		cdns_nand->irq_status.status |= irq_status.status;
+		cdns_nand->irq_status.trd_status |= irq_status.trd_status;
+		cdns_nand->irq_status.trd_error |= irq_status.trd_error;
+		/* notify anyone who cares that it happened */
+		complete(&cdns_nand->complete);
+		/* tell the OS that we've handled this */
+		result = IRQ_HANDLED;
+	}
+	spin_unlock(&cdns_nand->irq_lock);
+	return result;
+}
+
+static void
+cadence_nand_wait_for_irq(struct cdns_nand_info *cdns_nand,
+			  struct cadence_nand_irq_status *irq_mask,
+			  struct cadence_nand_irq_status *irq_status)
+{
+	unsigned long timeout = msecs_to_jiffies(10000);
+	unsigned long comp_res;
+
+	do {
+		comp_res = wait_for_completion_timeout(&cdns_nand->complete,
+						       timeout);
+		spin_lock_irq(&cdns_nand->irq_lock);
+		*irq_status = cdns_nand->irq_status;
+
+		if ((irq_status->status & irq_mask->status) ||
+		    (irq_status->trd_status & irq_mask->trd_status) ||
+		    (irq_status->trd_error & irq_mask->trd_error)) {
+			cdns_nand->irq_status.status &= ~irq_mask->status;
+			cdns_nand->irq_status.trd_status &=
+				~irq_mask->trd_status;
+			cdns_nand->irq_status.trd_error &= ~irq_mask->trd_error;
+			spin_unlock_irq(&cdns_nand->irq_lock);
+			/* our interrupt was detected */
+			break;
+		}
+
+		/*
+		 * these are not the interrupts you are looking for;
+		 * need to wait again
+		 */
+		spin_unlock_irq(&cdns_nand->irq_lock);
+	} while (comp_res != 0);
+
+	if (comp_res == 0) {
+		/* timeout */
+		dev_err(cdns_nand->dev, "timeout occurred:\n");
+		dev_err(cdns_nand->dev, "\tstatus = 0x%x, mask = 0x%x\n",
+			irq_status->status, irq_mask->status);
+		dev_err(cdns_nand->dev,
+			"\ttrd_status = 0x%x, trd_status mask = 0x%x\n",
+			irq_status->trd_status, irq_mask->trd_status);
+		dev_err(cdns_nand->dev,
+			"\t trd_error = 0x%x, trd_error mask = 0x%x\n",
+			irq_status->trd_error, irq_mask->trd_error);
+
+		memset(irq_status, 0, sizeof(struct cadence_nand_irq_status));
+	}
+}
+
+static void
+cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_info *cdns_nand)
+{
+	/* disable interrupts */
+	writel(INTR_ENABLE_INTR_EN, cdns_nand->reg + INTR_ENABLE);
+	free_irq(irqnum, cdns_nand);
+}
+
+/* wait until NAND flash device is ready */
+static int wait_for_rb_ready(struct cdns_nand_info *cdns_nand,
+			     unsigned int timeout_ms)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	u32 reg;
+
+	do {
+		reg = readl(cdns_nand->reg + RBN_SETINGS);
+		reg = (reg >> cdns_nand->chip.cur_cs) & 0x01;
+		cpu_relax();
+	} while ((reg == 0) && time_before(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		dev_err(cdns_nand->dev,
+			"Timeout while waiting for flash device %d ready\n",
+			cdns_nand->chip.cur_cs);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int
+cadence_nand_wait_for_thread(struct cdns_nand_info *cdns_nand, int8_t thread)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	u32 reg;
+
+	do {
+		/* get busy status of all threads */
+		reg = readl(cdns_nand->reg + TRD_STATUS);
+		/* mask all threads but selected */
+		reg &=	(1 << thread);
+	} while (reg && time_before(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		dev_err(cdns_nand->dev,
+			"Timeout while waiting for thread  %d\n",
+			thread);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cadence_nand_wait_for_idle(struct cdns_nand_info *cdns_nand)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	u32 reg;
+
+	do {
+		reg = readl(cdns_nand->reg + CTRL_STATUS);
+	} while ((reg & CTRL_STATUS_CTRL_BUSY) &&
+		 time_before(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		dev_err(cdns_nand->dev, "Timeout while waiting for controller idle\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/*  This function waits for device initialization */
+static int wait_for_init_complete(struct cdns_nand_info *cdns_nand)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10000);
+	u32 reg;
+
+	do {/* get ctrl status register */
+		reg = readl(cdns_nand->reg + CTRL_STATUS);
+	} while (((reg & CTRL_STATUS_INIT_COMP) == 0) &&
+		 time_before(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		dev_err(cdns_nand->dev,
+			"Timeout while waiting for controller init complete\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/* execute generic command on NAND controller */
+static int cadence_nand_generic_cmd_send(struct cdns_nand_info *cdns_nand,
+					 u8 thread_nr,
+					 u64 mini_ctrl_cmd,
+					 u8 use_intr)
+{
+	u32 mini_ctrl_cmd_l = mini_ctrl_cmd & 0xFFFFFFFF;
+	u32 mini_ctrl_cmd_h = mini_ctrl_cmd >> 32;
+	u32 reg = 0;
+	u8 status;
+
+	status = cadence_nand_wait_for_thread(cdns_nand, thread_nr);
+	if (status) {
+		dev_err(cdns_nand->dev,
+			"controller thread is busy cannot execute command\n");
+		return status;
+	}
+
+	cadence_nand_reset_irq(cdns_nand);
+
+	writel(mini_ctrl_cmd_l, cdns_nand->reg + CMD_REG2);
+	writel(mini_ctrl_cmd_h, cdns_nand->reg + CMD_REG3);
+
+	/* select generic command */
+	reg |= FIELD_PREP(CMD_REG0_CT, CMD_REG0_CT_GEN);
+	/* thread number */
+	reg |= FIELD_PREP(CMD_REG0_TN, thread_nr);
+	if (use_intr)
+		reg |= CMD_REG0_INT;
+
+	/* issue command */
+	writel(reg, cdns_nand->reg + CMD_REG0);
+
+	return 0;
+}
+
+/* wait for data on slave dma interface */
+static int cadence_nand_wait_on_sdma(struct cdns_nand_info *cdns_nand,
+				     u8 *out_sdma_trd,
+				     u32 *out_sdma_size)
+{
+	struct cadence_nand_irq_status irq_mask, irq_status;
+
+	irq_mask.trd_status = 0;
+	irq_mask.trd_error = 0;
+	irq_mask.status = INTR_STATUS_SDMA_TRIGG
+		| INTR_STATUS_SDMA_ERR
+		| INTR_STATUS_UNSUPP_CMD;
+
+	cadence_nand_wait_for_irq(cdns_nand, &irq_mask, &irq_status);
+	if (irq_status.status == 0) {
+		dev_err(cdns_nand->dev, "Timeout while waiting for SDMA\n");
+		return -ETIMEDOUT;
+	}
+
+	if (irq_status.status & INTR_STATUS_SDMA_TRIGG) {
+		*out_sdma_size = readl(cdns_nand->reg + SDMA_SIZE);
+		*out_sdma_trd  = readl(cdns_nand->reg + SDMA_TRD_NUM);
+		*out_sdma_trd =
+			FIELD_GET(SDMA_TRD_NUM_SDMA_TRD, *out_sdma_trd);
+	} else {
+		dev_err(cdns_nand->dev, "SDMA error - irq_status %x\n",
+			irq_status.status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void cadence_nand_get_caps(struct cdns_nand_info *cdns_nand)
+{
+	u32  reg;
+
+	reg =  readl(cdns_nand->reg + CTRL_FEATURES);
+
+	cdns_nand->caps.max_banks = FIELD_GET(CTRL_FEATURES_N_BANKS, reg);
+
+	if (FIELD_GET(CTRL_FEATURES_DMA_DWITH64, reg))
+		cdns_nand->caps.data_dma_width = 8;
+	else
+		cdns_nand->caps.data_dma_width = 4;
+
+	if (reg & CTRL_FEATURES_CONTROL_DATA)
+		cdns_nand->caps.data_control_supp = 1;
+}
+
+/* prepare CDMA descriptor */
+static void
+cadence_nand_cdma_desc_prepare(struct cadence_nand_cdma_desc *cdma_desc,
+			       char nf_mem, u32 flash_ptr, char *mem_ptr,
+			       char *ctrl_data_ptr, u16 ctype)
+{
+	memset(cdma_desc, 0, sizeof(struct cadence_nand_cdma_desc));
+
+	/* set fields for one descriptor */
+	cdma_desc->flash_pointer = (nf_mem << CDMA_CFPTR_MEM_SHIFT)
+		+ flash_ptr;
+	cdma_desc->command_flags |= CDMA_CF_DMA_MASTER;
+	cdma_desc->command_flags  |= CDMA_CF_INT;
+
+	cdma_desc->memory_pointer = (uintptr_t)mem_ptr;
+	cdma_desc->status = 0;
+	cdma_desc->sync_flag_pointer = 0;
+	cdma_desc->sync_arguments = 0;
+
+	cdma_desc->command_type = ctype;
+	cdma_desc->ctrl_data_ptr = (uintptr_t)ctrl_data_ptr;
+}
+
+static u8 cadence_nand_check_desc_error(u32 desc_status)
+{
+	if (desc_status & CDMA_CS_ERP)
+		return STAT_ERASED;
+
+	if (desc_status & CDMA_CS_UNCE)
+		return STAT_ECC_UNCORR;
+
+	if (desc_status & CDMA_CS_ERR) {
+		pr_err(CADENCE_NAND_NAME ":CDMA desc error flag detected.\n");
+		return STAT_FAIL;
+	}
+
+	if (FIELD_GET(CDMA_CS_MAXERR, desc_status))
+		return STAT_ECC_CORR;
+
+	return STAT_FAIL;
+}
+
+static int cadence_nand_cdma_finish(struct cdns_nand_info *cdns_nand,
+				    struct cadence_nand_cdma_desc *cdma_desc)
+{
+	struct cadence_nand_cdma_desc *desc_ptr;
+	u8 status = STAT_BUSY;
+
+	desc_ptr = cdma_desc;
+
+	if (desc_ptr->status & CDMA_CS_FAIL) {
+		status = cadence_nand_check_desc_error(desc_ptr->status);
+		dev_err(cdns_nand->dev, ":CDMA error %x\n", desc_ptr->status);
+	} else if (desc_ptr->status & CDMA_CS_COMP) {
+		/* descriptor finished with no errors */
+		if (desc_ptr->command_flags & CDMA_CF_CONT) {
+			dev_info(cdns_nand->dev, "DMA unsupported flag is set");
+			status = STAT_UNKNOWN;
+		} else {
+			/* last descriptor  */
+			status = STAT_OK;
+		}
+	}
+
+	return status;
+}
+
+static int cadence_nand_cdma_send(struct cdns_nand_info *cdns_nand,
+				  u8 thread)
+{
+	u32 reg = 0;
+	int status;
+
+	/* wait for thread ready*/
+	status = cadence_nand_wait_for_thread(cdns_nand, thread);
+	if (status)
+		return status;
+
+	cadence_nand_reset_irq(cdns_nand);
+
+	writel((u32)cdns_nand->dma_cdma_desc,
+	       cdns_nand->reg + CMD_REG2);
+	writel(0, cdns_nand->reg + CMD_REG3);
+
+	/* select CDMA mode */
+	reg |= FIELD_PREP(CMD_REG0_CT, CMD_REG0_CT_CDMA);
+	/* thread number */
+	reg |= FIELD_PREP(CMD_REG0_TN, thread);
+	/* issue command */
+	writel(reg, cdns_nand->reg + CMD_REG0);
+
+	return 0;
+}
+
+/* send SDMA command and wait for finish */
+static u32
+cadence_nand_cdma_send_and_wait(struct cdns_nand_info *cdns_nand,
+				u8 thread)
+{
+	struct cadence_nand_irq_status irq_mask, irq_status = {0};
+	int status;
+
+	status = cadence_nand_cdma_send(cdns_nand, thread);
+	if (status)
+		return status;
+
+	irq_mask.trd_status = 1 << thread;
+	irq_mask.trd_error = 1 << thread;
+	irq_mask.status = INTR_STATUS_CDMA_TERR;
+	cadence_nand_wait_for_irq(cdns_nand, &irq_mask, &irq_status);
+
+	if (irq_status.status == 0 && irq_status.trd_status == 0 &&
+	    irq_status.trd_error == 0) {
+		dev_err(cdns_nand->dev, "CDMA command timeout\n");
+		return -ETIMEDOUT;
+	}
+	if (irq_status.status & irq_mask.status) {
+		dev_err(cdns_nand->dev, "CDMA command failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* ECC size depends on configured ECC strength and on maximum supported
+ * ECC step size
+ */
+static int cadence_nand_calc_ecc_bytes(int max_step_size, int strength)
+{
+	u32 result;
+	u8 mult;
+
+	switch (max_step_size) {
+	case 256:
+		mult = 12;
+		break;
+	case 512:
+		mult = 13;
+		break;
+	case 1024:
+		mult = 14;
+		break;
+	case 2048:
+		mult = 15;
+		break;
+	case 4096:
+		mult = 16;
+		break;
+	default:
+		pr_err("%s: max_step_size %d\n", __func__, max_step_size);
+		return -EINVAL;
+	}
+
+	result = (mult * strength) / 16;
+	/* round up */
+	if ((result * 16) < (mult * strength))
+		result++;
+
+	/* check bit size per one sector */
+	result = 2 * result;
+
+	return result;
+}
+
+static int cadence_nand_calc_ecc_bytes_256(int step_size, int strength)
+{
+	return cadence_nand_calc_ecc_bytes(256, strength);
+}
+
+static int cadence_nand_calc_ecc_bytes_512(int step_size, int strength)
+{
+	return cadence_nand_calc_ecc_bytes(512, strength);
+}
+
+static int cadence_nand_calc_ecc_bytes_1024(int step_size, int strength)
+{
+	return cadence_nand_calc_ecc_bytes(1024, strength);
+}
+
+static int cadence_nand_calc_ecc_bytes_2048(int step_size, int strength)
+{
+	return  cadence_nand_calc_ecc_bytes(2048, strength);
+}
+
+static int cadence_nand_calc_ecc_bytes_4096(int step_size, int strength)
+{
+	return  cadence_nand_calc_ecc_bytes(4096, strength);
+}
+
+/* function reads BCH configuration  */
+static int cadence_nand_read_bch_cfg(struct cdns_nand_info *cdns_nand)
+{
+	struct nand_ecc_caps *ecc_caps = &cdns_nand->ecc_caps;
+	int max_step_size = 0;
+	int nstrengths;
+	u32 reg;
+	int i;
+
+	reg = readl(cdns_nand->reg + BCH_CFG_0);
+	cdns_nand->ecc_strengths[0] = FIELD_GET(BCH_CFG_0_CORR_CAP_0, reg);
+	cdns_nand->ecc_strengths[1] = FIELD_GET(BCH_CFG_0_CORR_CAP_1, reg);
+	cdns_nand->ecc_strengths[2] = FIELD_GET(BCH_CFG_0_CORR_CAP_2, reg);
+	cdns_nand->ecc_strengths[3] = FIELD_GET(BCH_CFG_0_CORR_CAP_3, reg);
+
+	reg = readl(cdns_nand->reg + BCH_CFG_1);
+	cdns_nand->ecc_strengths[4] = FIELD_GET(BCH_CFG_1_CORR_CAP_4, reg);
+	cdns_nand->ecc_strengths[5] = FIELD_GET(BCH_CFG_1_CORR_CAP_5, reg);
+	cdns_nand->ecc_strengths[6] = FIELD_GET(BCH_CFG_1_CORR_CAP_6, reg);
+	cdns_nand->ecc_strengths[7] = FIELD_GET(BCH_CFG_1_CORR_CAP_7, reg);
+
+	reg = readl(cdns_nand->reg + BCH_CFG_2);
+	cdns_nand->ecc_stepinfos[0].stepsize =
+		FIELD_GET(BCH_CFG_2_SECT_0, reg);
+
+	cdns_nand->ecc_stepinfos[1].stepsize =
+		FIELD_GET(BCH_CFG_2_SECT_1, reg);
+
+	nstrengths = 0;
+	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
+		if (cdns_nand->ecc_strengths[i] != 0)
+			nstrengths++;
+	}
+
+	ecc_caps->nstepinfos = 0;
+	for (i = 0; i < BCH_MAX_NUM_SECTOR_SIZES; i++) {
+		/* ECC strengths are common for all step infos */
+		cdns_nand->ecc_stepinfos[i].nstrengths = nstrengths;
+		cdns_nand->ecc_stepinfos[i].strengths =
+			cdns_nand->ecc_strengths;
+
+		if (cdns_nand->ecc_stepinfos[i].stepsize != 0)
+			ecc_caps->nstepinfos++;
+
+		if (cdns_nand->ecc_stepinfos[i].stepsize > max_step_size)
+			max_step_size = cdns_nand->ecc_stepinfos[i].stepsize;
+	}
+
+	ecc_caps->stepinfos = &cdns_nand->ecc_stepinfos[0];
+
+	switch (max_step_size) {
+	case 256:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_256;
+		break;
+	case 512:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_512;
+		break;
+	case 1024:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_1024;
+		break;
+	case 2048:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_2048;
+		break;
+	case 4096:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_4096;
+		break;
+	default:
+		dev_err(cdns_nand->dev,
+			"Unsupported sector size(ecc step size) %d\n",
+			max_step_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* hardware initialization */
+static int cadence_nand_hw_init(struct cdns_nand_info *cdns_nand)
+{
+	int status = 0;
+	u32 reg;
+
+	status = wait_for_init_complete(cdns_nand);
+	if (status)
+		return status;
+
+	reg = readl(cdns_nand->reg + CTRL_VERSION);
+
+	dev_info(cdns_nand->dev,
+		 "%s: cadence nand controller version reg %x\n",
+		 __func__, reg);
+
+	/* disable cache and multiplane */
+	writel(0, cdns_nand->reg + MULTIPLANE_CFG);
+	writel(0, cdns_nand->reg + CACHE_CFG);
+
+	/* enable interrupts */
+	reg = INTR_ENABLE_INTR_EN
+		| INTR_ENABLE_CDMA_TERR_EN
+		| INTR_ENABLE_DDMA_TERR_EN
+		| INTR_ENABLE_UNSUPP_CMD_EN
+		| INTR_ENABLE_SDMA_TRIGG_EN
+		| INTR_ENABLE_SDMA_ERR_EN;
+	writel(reg, cdns_nand->reg + INTR_ENABLE);
+	/* clear all interrupts */
+	writel(0xFFFFFFFF, cdns_nand->reg + INTR_STATUS);
+	/* enable signaling thread error interrupts for all threads  */
+	writel(0xFF, cdns_nand->reg + TRD_ERR_INT_STATUS_EN);
+
+	cadence_nand_get_caps(cdns_nand);
+	cadence_nand_read_bch_cfg(cdns_nand);
+
+	/* set io width access to 8
+	 * it is because during SW device dicovering width access
+	 * is expected to be 8
+	 */
+	status = cadence_nand_set_access_width(cdns_nand, 8);
+
+	return status;
+}
+
+#define TT_OOB_AREA		1
+#define TT_MAIN_OOB_AREAS	2
+#define TT_RAW_PAGE		3
+#define TT_BBM			4
+#define TT_MAIN_OOB_AREA_EXT	5
+
+/* prepare size of data to transfer */
+static int
+cadence_nand_prepare_data_size(struct cdns_nand_info *cdns_nand,
+			       int transfer_type)
+{
+	u32 sec_size = 0, last_sec_size, offset, sec_cnt;
+	u32 ecc_size = cdns_nand->chip.ecc.bytes;
+	u32 data_ctrl_size = 0;
+	u32 reg = 0;
+
+	if (cdns_nand->curr_trans_type == transfer_type)
+		return 0;
+
+	switch (transfer_type) {
+	case TT_OOB_AREA:
+		offset = cdns_nand->main_size - cdns_nand->sector_size;
+		ecc_size = ecc_size * (offset / cdns_nand->sector_size);
+		offset = offset + ecc_size;
+		sec_cnt = 1;
+		last_sec_size = cdns_nand->sector_size
+			+ cdns_nand->avail_oob_size;
+		break;
+	case TT_MAIN_OOB_AREA_EXT:
+		offset = 0;
+		sec_cnt = cdns_nand->sector_count;
+		last_sec_size = cdns_nand->sector_size;
+		sec_size = cdns_nand->sector_size;
+		data_ctrl_size = cdns_nand->avail_oob_size;
+		break;
+	case TT_MAIN_OOB_AREAS:
+		offset = 0;
+		sec_cnt = cdns_nand->sector_count;
+		last_sec_size = cdns_nand->sector_size
+			+ cdns_nand->avail_oob_size;
+		sec_size = cdns_nand->sector_size;
+		break;
+	case TT_RAW_PAGE:
+		offset = 0;
+		sec_cnt = 1;
+		last_sec_size = cdns_nand->main_size + cdns_nand->oob_size;
+		break;
+	case TT_BBM:
+		offset = cdns_nand->main_size + cdns_nand->bbm_offs;
+		sec_cnt = 1;
+		last_sec_size = 8;
+		break;
+	default:
+		dev_err(cdns_nand->dev, "Data size preparation failed\n");
+		return -EINVAL;
+	}
+
+	reg = 0;
+	reg |= FIELD_PREP(TRAN_CFG_0_OFFSET, offset);
+	reg |= FIELD_PREP(TRAN_CFG_0_SEC_CNT, sec_cnt);
+	writel(reg, cdns_nand->reg + TRAN_CFG_0);
+
+	reg = 0;
+	reg |= FIELD_PREP(TRAN_CFG_1_LAST_SEC_SIZE, last_sec_size);
+	reg |= FIELD_PREP(TRAN_CFG_1_SECTOR_SIZE, sec_size);
+	writel(reg, cdns_nand->reg + TRAN_CFG_1);
+
+	reg = readl(cdns_nand->reg + CONTROL_DATA_CTRL);
+	reg &= ~CONTROL_DATA_CTRL_SIZE;
+	reg |= FIELD_PREP(CONTROL_DATA_CTRL_SIZE, data_ctrl_size);
+	writel(reg, cdns_nand->reg + CONTROL_DATA_CTRL);
+
+	cdns_nand->curr_trans_type = transfer_type;
+
+	return 0;
+}
+
+static int
+cadence_nand_cdma_transfer(struct mtd_info *mtd, int page, void *buf,
+			   void *ctrl_dat, u32 buf_size,
+			   u32 ctrl_dat_size, enum dma_data_direction dir,
+			   bool with_ecc)
+{
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	struct cadence_nand_cdma_desc *cdma_desc = cdns_nand->cdma_desc;
+	dma_addr_t dma_buf = 0, dma_ctrl_dat = 0;
+	u8 thread_nr = cdns_nand->chip.cur_cs;
+	int status = 0;
+	u16 ctype;
+
+	if (dir == DMA_FROM_DEVICE)
+		ctype = CDMA_CT_RD;
+	else
+		ctype = CDMA_CT_WR;
+
+	cadence_nand_set_ecc_enable(cdns_nand, with_ecc);
+
+	dma_buf = dma_map_single(cdns_nand->dev, buf, buf_size, dir);
+	if (dma_mapping_error(cdns_nand->dev, dma_buf)) {
+		dev_err(cdns_nand->dev, "Failed to map DMA buffer\n");
+		return -EIO;
+	}
+
+	if (ctrl_dat && ctrl_dat_size) {
+		dma_ctrl_dat = dma_map_single(cdns_nand->dev, ctrl_dat,
+					      ctrl_dat_size, dir);
+		if (dma_mapping_error(cdns_nand->dev, dma_ctrl_dat)) {
+			dma_unmap_single(cdns_nand->dev, dma_buf,
+					 buf_size, dir);
+			dev_err(cdns_nand->dev, "Failed to map DMA buffer\n");
+			return -EIO;
+		}
+	}
+
+	cadence_nand_cdma_desc_prepare(cdma_desc, cdns_nand->chip.cur_cs, page,
+				       (void *)dma_buf, (void *)dma_ctrl_dat,
+				       ctype);
+
+	status = cadence_nand_cdma_send_and_wait(cdns_nand, thread_nr);
+
+	dma_unmap_single(cdns_nand->dev, dma_buf,
+			 buf_size, dir);
+
+	if (ctrl_dat && ctrl_dat_size)
+		dma_unmap_single(cdns_nand->dev, dma_ctrl_dat,
+				 ctrl_dat_size, dir);
+	if (status)
+		return status;
+
+	return cadence_nand_cdma_finish(cdns_nand, cdns_nand->cdma_desc);
+}
+
+/* get corrected ECC errors of last read operation */
+static u32 get_ecc_count(struct cdns_nand_info *cdns_nand)
+{
+	return FIELD_GET(CDMA_CS_MAXERR, cdns_nand->cdma_desc->status);
+}
+
+static int cadence_nand_block_markbad(struct nand_chip *chip, loff_t ofs)
+{
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret = 0, res = 0, i = 0;
+
+	memset(cdns_nand->buf, 0xFF, mtd->oobsize);
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, 0, 0, 0);
+
+	memset(cdns_nand->buf, 0, cdns_nand->bbm_len);
+
+	/* Write to first/last page(s) if necessary */
+	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
+		ofs += mtd->erasesize - mtd->writesize;
+	do {
+		int chipnr = (int)(ofs >> chip->chip_shift);
+		int page = (int)(ofs >> chip->page_shift);
+
+		nand_select_target(chip, chipnr);
+
+		/* configure controller to program only a spare area */
+		res = cadence_nand_prepare_data_size(cdns_nand, TT_BBM);
+		if (res) {
+			ret = -EIO;
+			break;
+		}
+
+		res = cadence_nand_cdma_transfer(mtd, page,
+						 cdns_nand->buf, NULL,
+						 mtd->oobsize,
+						 0, DMA_TO_DEVICE, false);
+		if (res) {
+			ret = -EIO;
+			break;
+		}
+
+		i++;
+		ofs += mtd->writesize;
+
+		nand_select_target(chip, -1);
+	} while ((chip->bbt_options & NAND_BBT_SCAN2NDPAGE) && i < 2);
+
+	return ret;
+}
+
+static int cadence_nand_write_oob(struct nand_chip *chip, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	u8 *buf = chip->oob_poi;
+	u32 bbm_offset;
+	int status = 0;
+
+	bbm_offset = (cdns_nand->sector_count - 1) * (cdns_nand->sector_size
+						  + cdns_nand->chip.ecc.bytes);
+	bbm_offset = mtd->writesize - bbm_offset + cdns_nand->bbm_offs;
+
+	/* to preseve page layout with ECC enabled
+	 * we send also one data sector filled with 0xFF
+	 * <0xFF 0xFF ....><oob data><HW calculated ECC>
+	 */
+	memset(cdns_nand->buf, 0xFF, cdns_nand->sector_size);
+	memcpy(cdns_nand->buf + cdns_nand->sector_size, buf,
+	       cdns_nand->avail_oob_size);
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, cdns_nand->bbm_len,
+					 bbm_offset, 1);
+	cadence_nand_set_skip_marker_val(cdns_nand,
+					 *(u16 *)(buf +
+						       cdns_nand->bbm_offs));
+
+	status = cadence_nand_prepare_data_size(cdns_nand, TT_OOB_AREA);
+	if (status) {
+		dev_err(cdns_nand->dev, "write oob failed\n");
+		return status;
+	}
+
+	return cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					  cdns_nand->sector_size
+					  + cdns_nand->avail_oob_size,
+					  0, DMA_TO_DEVICE, true);
+}
+
+/* reads OOB data from the device */
+static int cadence_nand_read_oob(struct nand_chip *chip,
+				 int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	int status = 0;
+	u8 *buf = chip->oob_poi;
+	u32 bbm_offset;
+
+	status = cadence_nand_prepare_data_size(cdns_nand, TT_OOB_AREA);
+	if (status)
+		return -EIO;
+
+	bbm_offset = (cdns_nand->sector_count - 1) * (cdns_nand->sector_size
+						  + cdns_nand->chip.ecc.bytes);
+	bbm_offset = mtd->writesize - bbm_offset + cdns_nand->bbm_offs;
+	cadence_nand_set_skip_bytes_conf(cdns_nand, cdns_nand->bbm_len,
+					 bbm_offset, 1);
+
+	/* read last sector and spare data
+	 * to be able to calculate ECC properly by controller
+	 */
+	status = cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					    cdns_nand->sector_size
+					    + cdns_nand->avail_oob_size,
+					    0, DMA_FROM_DEVICE, true);
+
+	switch (status) {
+	case STAT_ECC_UNCORR:
+		dev_warn(cdns_nand->dev, "ECC errors occur in read oob function\n");
+		break;
+	case STAT_OK:
+		break;
+	case STAT_ERASED:
+		dev_warn(cdns_nand->dev,
+			 "Block is erased occur in read oob function\n");
+		break;
+	case STAT_ECC_CORR:
+		break;
+	default:
+		dev_err(cdns_nand->dev, "read oob failed err %d\n", status);
+		return -EIO;
+	}
+
+	/* ignore sector data, copy only oob data*/
+	memcpy(buf, cdns_nand->buf + cdns_nand->sector_size,
+	       cdns_nand->avail_oob_size);
+	status = cadence_nand_prepare_data_size(cdns_nand, TT_BBM);
+	if (status)
+		return -EIO;
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, 0, 0, 0);
+
+	/* read only bad block marker from offset
+	 * defined by a memory manufacturer
+	 */
+	status = cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					    mtd->oobsize,
+					    0, DMA_FROM_DEVICE, false);
+	if (status) {
+		dev_err(cdns_nand->dev, "read BBM failed\n");
+		return -EIO;
+	}
+
+	memcpy(buf + cdns_nand->bbm_offs, cdns_nand->buf, cdns_nand->bbm_len);
+
+	return 0;
+}
+
+static int cadence_nand_write_page(struct nand_chip *chip,
+				   const u8 *buf, int oob_required,
+				   int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	int status = 0;
+	u16 marker_val = 0xFFFF;
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, cdns_nand->bbm_len,
+					 mtd->writesize + cdns_nand->bbm_offs,
+					 1);
+
+	if (oob_required) {
+		marker_val = *(u16 *)(chip->oob_poi
+					   + cdns_nand->bbm_offs);
+	} else {
+		/* just set oob data to 0xFF */
+		memset(cdns_nand->buf + mtd->writesize, 0xFF,
+		       cdns_nand->avail_oob_size);
+	}
+
+	cadence_nand_set_skip_marker_val(cdns_nand, marker_val);
+
+	status = cadence_nand_prepare_data_size(cdns_nand,
+						TT_MAIN_OOB_AREA_EXT);
+	if (status) {
+		dev_err(cdns_nand->dev, "write page failed\n");
+		return -EIO;
+	}
+
+	if (cadence_nand_dma_buf_ok(cdns_nand, buf, mtd->writesize) &&
+	    cdns_nand->caps.data_control_supp) {
+		u8 *oob;
+
+		if (oob_required)
+			oob = chip->oob_poi;
+		else
+			oob = cdns_nand->buf + mtd->writesize;
+
+		status = cadence_nand_cdma_transfer(mtd, page, (void *)buf, oob,
+						    mtd->writesize,
+						    cdns_nand->avail_oob_size,
+						    DMA_TO_DEVICE, true);
+		if (status) {
+			dev_err(cdns_nand->dev, "write page failed\n");
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	if (oob_required) {
+		/* transfer the data to the oob area */
+		memcpy(cdns_nand->buf + mtd->writesize, chip->oob_poi,
+		       cdns_nand->avail_oob_size);
+	}
+
+	memcpy(cdns_nand->buf, buf, mtd->writesize);
+
+	cadence_nand_prepare_data_size(cdns_nand, TT_MAIN_OOB_AREAS);
+
+	return cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					  mtd->writesize
+					  + cdns_nand->avail_oob_size,
+					  0, DMA_TO_DEVICE, true);
+}
+
+static int cadence_nand_write_page_raw(struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	int writesize = mtd->writesize;
+	int oobsize = mtd->oobsize;
+	int ecc_steps = chip->ecc.steps;
+	int ecc_size = chip->ecc.size;
+	int ecc_bytes = chip->ecc.bytes;
+	void *tmp_buf = cdns_nand->buf;
+	int oob_skip = cdns_nand->bbm_len;
+	size_t size = writesize + oobsize;
+	int i, pos, len;
+	int status = 0;
+
+	/*
+	 * Fill the buffer with 0xff first except the full page transfer.
+	 * This simplifies the logic.
+	 */
+	if (!buf || !oob_required)
+		memset(tmp_buf, 0xff, size);
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, 0, 0, 0);
+
+	/* Arrange the buffer for syndrome payload/ecc layout */
+	if (buf) {
+		for (i = 0; i < ecc_steps; i++) {
+			pos = i * (ecc_size + ecc_bytes);
+			len = ecc_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(tmp_buf + pos, buf, len);
+			buf += len;
+			if (len < ecc_size) {
+				len = ecc_size - len;
+				memcpy(tmp_buf + writesize + oob_skip, buf,
+				       len);
+				buf += len;
+			}
+		}
+	}
+
+	if (oob_required) {
+		const u8 *oob = chip->oob_poi;
+		u32 oob_data_offset = (cdns_nand->sector_count - 1) *
+			(cdns_nand->sector_size + cdns_nand->chip.ecc.bytes)
+			+ cdns_nand->sector_size + oob_skip;
+
+		/* BBM at the beginning of the OOB area */
+		memcpy(tmp_buf + writesize, oob, oob_skip);
+
+		/* OOB free */
+		memcpy(tmp_buf + oob_data_offset, oob,
+		       cdns_nand->avail_oob_size);
+		oob += cdns_nand->avail_oob_size;
+
+		/* OOB ECC */
+		for (i = 0; i < ecc_steps; i++) {
+			pos = ecc_size + i * (ecc_size + ecc_bytes);
+			if (i == (ecc_steps - 1))
+				pos += cdns_nand->avail_oob_size;
+
+			len = ecc_bytes;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(tmp_buf + pos, oob, len);
+			oob += len;
+			if (len < ecc_bytes) {
+				len = ecc_bytes - len;
+				memcpy(tmp_buf + writesize + oob_skip, oob,
+				       len);
+				oob += len;
+			}
+		}
+	}
+
+	status = cadence_nand_prepare_data_size(cdns_nand, TT_RAW_PAGE);
+	if (status) {
+		dev_err(cdns_nand->dev, "write page failed\n");
+		return -EIO;
+	}
+
+	return cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					  mtd->writesize + mtd->oobsize,
+					  0, DMA_TO_DEVICE, false);
+}
+
+static int cadence_nand_write_oob_raw(struct nand_chip *chip,
+				      int page)
+{
+	return cadence_nand_write_page_raw(chip, NULL, true, page);
+}
+
+static int cadence_nand_read_page(struct nand_chip *chip,
+				  u8 *buf, int oob_required, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	int status = 0;
+	int ecc_err_count = 0;
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, cdns_nand->bbm_len,
+					 cdns_nand->main_size
+					 + cdns_nand->bbm_offs, 1);
+
+	/* if data buffer is can be accessed by DMA and data_control feature
+	 * is supported then transfer data and oob directly
+	 */
+	if (cadence_nand_dma_buf_ok(cdns_nand, buf, mtd->writesize) &&
+	    cdns_nand->caps.data_control_supp) {
+		u8 *oob;
+
+		if (oob_required)
+			oob = chip->oob_poi;
+		else
+			oob = cdns_nand->buf + mtd->writesize;
+
+		cadence_nand_prepare_data_size(cdns_nand, TT_MAIN_OOB_AREA_EXT);
+		status = cadence_nand_cdma_transfer(mtd, page, buf, oob,
+						    mtd->writesize,
+						    cdns_nand->avail_oob_size,
+						    DMA_FROM_DEVICE, true);
+	/* otherwise use bounce buffer */
+	} else {
+		cadence_nand_prepare_data_size(cdns_nand, TT_MAIN_OOB_AREAS);
+		status = cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf,
+						    NULL, mtd->writesize
+						    + cdns_nand->avail_oob_size,
+						    0, DMA_FROM_DEVICE, true);
+
+		memcpy(buf, cdns_nand->buf, mtd->writesize);
+		if (oob_required)
+			memcpy(chip->oob_poi, cdns_nand->buf + mtd->writesize,
+			       mtd->oobsize);
+	}
+
+	switch (status) {
+	case STAT_ECC_UNCORR:
+		mtd->ecc_stats.failed++;
+		ecc_err_count++;
+		break;
+	case STAT_ECC_CORR:
+		ecc_err_count = get_ecc_count(cdns_nand);
+		mtd->ecc_stats.corrected += ecc_err_count;
+		break;
+	case STAT_ERASED:
+	case STAT_OK:
+		break;
+	default:
+		dev_err(cdns_nand->dev, "read page failed\n");
+		return -EIO;
+	}
+
+	if (oob_required) {
+		cadence_nand_set_skip_bytes_conf(cdns_nand, 0, 0, 0);
+
+		status = cadence_nand_prepare_data_size(cdns_nand, TT_BBM);
+		if (status)
+			return -EIO;
+
+		/* read only bad block marker */
+		status = cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf,
+						    NULL, mtd->oobsize,
+						    0, DMA_FROM_DEVICE, false);
+		if (status) {
+			dev_err(cdns_nand->dev, "read BBM failed\n");
+			return -EIO;
+		}
+
+		memcpy(chip->oob_poi + cdns_nand->bbm_offs, cdns_nand->buf,
+		       cdns_nand->bbm_len);
+	}
+
+	return ecc_err_count;
+}
+
+static int cadence_nand_read_page_raw(struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int oob_skip = cdns_nand->bbm_len;
+	int writesize = mtd->writesize;
+	int ecc_steps = chip->ecc.steps;
+	int ecc_size = chip->ecc.size;
+	int ecc_bytes = chip->ecc.bytes;
+	void *tmp_buf = cdns_nand->buf;
+	int i, pos, len;
+	int status = 0;
+
+	cadence_nand_set_skip_bytes_conf(cdns_nand, 0, 0, 0);
+
+	cadence_nand_prepare_data_size(cdns_nand, TT_RAW_PAGE);
+	status = cadence_nand_cdma_transfer(mtd, page, cdns_nand->buf, NULL,
+					    mtd->writesize + mtd->oobsize,
+					    0, DMA_FROM_DEVICE, false);
+
+	switch (status) {
+	case STAT_ERASED:
+	case STAT_OK:
+		break;
+	default:
+		dev_err(cdns_nand->dev, "read raw page failed\n");
+		return -EIO;
+	}
+
+	/* Arrange the buffer for syndrome payload/ecc layout */
+	if (buf) {
+		for (i = 0; i < ecc_steps; i++) {
+			pos = i * (ecc_size + ecc_bytes);
+			len = ecc_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(buf, tmp_buf + pos, len);
+			buf += len;
+			if (len < ecc_size) {
+				len = ecc_size - len;
+				memcpy(buf, tmp_buf + writesize + oob_skip,
+				       len);
+				buf += len;
+			}
+		}
+	}
+
+	if (oob_required) {
+		u8 *oob = chip->oob_poi;
+		u32 oob_data_offset = (cdns_nand->sector_count - 1) *
+			(cdns_nand->sector_size + cdns_nand->chip.ecc.bytes)
+			+ cdns_nand->sector_size + oob_skip;
+
+		/* OOB free */
+		memcpy(oob, tmp_buf + oob_data_offset,
+		       cdns_nand->avail_oob_size);
+
+		/* BBM at the beginning of the OOB area */
+		memcpy(oob, tmp_buf + writesize, oob_skip);
+
+		oob += cdns_nand->avail_oob_size;
+
+		/* OOB ECC */
+		for (i = 0; i < ecc_steps; i++) {
+			pos = ecc_size + i * (ecc_size + ecc_bytes);
+			len = ecc_bytes;
+
+			if (i == (ecc_steps - 1))
+				pos += cdns_nand->avail_oob_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(oob, tmp_buf + pos, len);
+			oob += len;
+			if (len < ecc_bytes) {
+				len = ecc_bytes - len;
+				memcpy(oob, tmp_buf + writesize + oob_skip,
+				       len);
+				oob += len;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int cadence_nand_read_oob_raw(struct nand_chip *chip,
+				     int page)
+{
+	return cadence_nand_read_page_raw(chip, NULL, true, page);
+}
+
+static void cadence_nand_slave_dma_transfer_finished(void *data)
+{
+	struct completion *finished = data;
+
+	complete(finished);
+}
+
+static int cadence_nand_slave_dma_transfer(struct cdns_nand_info *cdns_nand,
+					   void *buf,
+					   dma_addr_t dev_dma, size_t len,
+					   enum dma_data_direction dir)
+{
+	DECLARE_COMPLETION_ONSTACK(finished);
+	struct dma_chan *chan;
+	struct dma_device *dma_dev;
+	dma_addr_t src_dma, dst_dma, buf_dma;
+	struct dma_async_tx_descriptor *tx;
+	dma_cookie_t cookie;
+
+	chan = cdns_nand->dmac;
+	dma_dev = chan->device;
+
+	buf_dma = dma_map_single(dma_dev->dev, buf, len, dir);
+	if (dma_mapping_error(dma_dev->dev, buf_dma)) {
+		dev_err(cdns_nand->dev, "Failed to map DMA buffer\n");
+		goto err;
+	}
+
+	if (dir == DMA_FROM_DEVICE) {
+		src_dma = cdns_nand->io.dma;
+		dst_dma = buf_dma;
+	} else {
+		src_dma = buf_dma;
+		dst_dma = cdns_nand->io.dma;
+	}
+
+	tx = dmaengine_prep_dma_memcpy(cdns_nand->dmac, dst_dma, src_dma, len,
+				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!tx) {
+		dev_err(cdns_nand->dev, "Failed to prepare DMA memcpy\n");
+		goto err_unmap;
+	}
+
+	tx->callback = cadence_nand_slave_dma_transfer_finished;
+	tx->callback_param = &finished;
+
+	cookie = dmaengine_submit(tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(cdns_nand->dev, "Failed to do DMA tx_submit\n");
+		goto err_unmap;
+	}
+
+	dma_async_issue_pending(cdns_nand->dmac);
+	wait_for_completion(&finished);
+
+	dma_unmap_single(cdns_nand->dev, buf_dma, len, dir);
+
+	return 0;
+
+err_unmap:
+	dma_unmap_single(cdns_nand->dev, buf_dma, len, dir);
+
+err:
+	dev_dbg(cdns_nand->dev, "Fall back to CPU I/O\n");
+
+	return -EIO;
+}
+
+static int cadence_nand_read_buf(struct cdns_nand_info *cdns_nand,
+				 u8 *buf, int len)
+{
+	int len_aligned = ALIGN(len, cdns_nand->caps.data_dma_width);
+	u8 thread_nr = 0;
+	u32 sdma_size;
+	int ret, status = 0;
+
+	if (!cdns_nand->caps.has_dma) {
+		if (len & 3) {
+			dev_err(cdns_nand->dev, "unaligned data\n");
+			return -EIO;
+		}
+		readsl(cdns_nand->io.virt, buf, len / 4);
+		return 0;
+	}
+
+	/* wait until slave DMA interface is ready to data transfer */
+	ret = cadence_nand_wait_on_sdma(cdns_nand, &thread_nr, &sdma_size);
+	if (ret)
+		return ret;
+
+	if (sdma_size != len_aligned) {
+		dev_err(cdns_nand->dev, "unexpected scenario\n");
+		return -EIO;
+	}
+
+	if (cdns_nand->dmac && cadence_nand_dma_buf_ok(cdns_nand, buf, len)) {
+		status = cadence_nand_slave_dma_transfer(cdns_nand, buf,
+							 cdns_nand->io.dma,
+							 len, DMA_FROM_DEVICE);
+		if (status == 0)
+			return 0;
+
+		dev_warn(cdns_nand->dev,
+			 "Slave DMA transfer failed. Try again using bounce buffer.");
+	}
+
+	/* if DMA transfer is not possible or failed then use bounce buffer */
+	status = cadence_nand_slave_dma_transfer(cdns_nand, cdns_nand->buf,
+						 cdns_nand->io.dma,
+						 len_aligned, DMA_FROM_DEVICE);
+
+	if (status) {
+		dev_err(cdns_nand->dev, "Slave DMA transfer failed");
+		return status;
+	}
+
+	memcpy(buf, cdns_nand->buf, len);
+
+	return 0;
+}
+
+static int cadence_nand_write_buf(struct cdns_nand_info *cdns_nand,
+				  const u8 *buf, int len)
+{
+	u8 thread_nr = 0;
+	u32 sdma_size;
+	int ret, status = 0;
+	int len_aligned = ALIGN(len, cdns_nand->caps.data_dma_width);
+
+	if (!cdns_nand->caps.has_dma) {
+		if (len & 3) {
+			dev_err(cdns_nand->dev, "unaligned data\n");
+			return -EIO;
+		}
+		writesl(cdns_nand->io.virt, buf, len / 4);
+		return 0;
+	}
+
+	/* wait until slave DMA interface is ready to data transfer */
+	ret = cadence_nand_wait_on_sdma(cdns_nand, &thread_nr, &sdma_size);
+	if (ret)
+		return ret;
+
+	if (sdma_size != len_aligned) {
+		dev_err(cdns_nand->dev, "Error unexpected scenario\n");
+		return -EIO;
+	}
+
+	if (cdns_nand->dmac && cadence_nand_dma_buf_ok(cdns_nand, buf, len)) {
+		status = cadence_nand_slave_dma_transfer(cdns_nand, (void *)buf,
+							 cdns_nand->io.dma,
+							 len, DMA_TO_DEVICE);
+		if (status == 0)
+			return 0;
+
+		dev_warn(cdns_nand->dev,
+			 "Slave DMA transfer failed. Try again using bounce buffer.");
+	}
+
+	/* if DMA transfer is not possible or failed then use bounce buffer */
+	memcpy(cdns_nand->buf, buf, len);
+
+	status = cadence_nand_slave_dma_transfer(cdns_nand, cdns_nand->buf,
+						 cdns_nand->io.dma,
+						 len_aligned, DMA_TO_DEVICE);
+
+	if (status)
+		dev_err(cdns_nand->dev, "Slave DMA transfer failed");
+
+	return status;
+}
+
+static int cadence_nand_exec_op(struct nand_chip *chip,
+				const struct nand_operation *op,
+				bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &cadence_nand_op_parser, op,
+				      check_only);
+}
+
+static int cadence_nand_force_byte_access(struct nand_chip *chip,
+					  bool force_8bit)
+{
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+	int status;
+
+	/*
+	 * Callers of this function do not verify if the NAND is using a 16-bit
+	 * an 8-bit bus for normal operations, so we need to take care of that
+	 * here by leaving the configuration unchanged if the NAND does not have
+	 * the NAND_BUSWIDTH_16 flag set.
+	 */
+	if (!(chip->options & NAND_BUSWIDTH_16))
+		return 0;
+
+	if (force_8bit)
+		status = cadence_nand_set_access_width(cdns_nand, 8);
+	else
+		status = cadence_nand_set_access_width(cdns_nand, 16);
+
+	return status;
+}
+
+static int cadence_nand_cmd(struct nand_chip *chip,
+			    const struct nand_subop *subop)
+{
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+	const struct nand_op_instr *instr;
+	unsigned int offset, naddrs;
+	u64 mini_ctrl_cmd = 0;
+	bool is_data_instr = false;
+	unsigned int op_id = 0;
+	u8 thread_nr = 0;
+	u64 address = 0;
+	const u8 *addrs;
+	unsigned int i;
+	int len = 0;
+	int ret;
+
+	instr = &subop->instrs[op_id];
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_CS, chip->cur_cs);
+	if (instr->delay_ns > 0)
+		mini_ctrl_cmd |= GCMD_LAY_TWB;
+
+	switch (instr->type) {
+	case NAND_OP_CMD_INSTR:
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+					    GCMD_LAY_INSTR_CMD);
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_CMD,
+					    instr->ctx.cmd.opcode);
+		break;
+
+	case NAND_OP_ADDR_INSTR:
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+					    GCMD_LAY_INSTR_ADDR);
+
+		offset = nand_subop_get_addr_start_off(subop, op_id);
+		naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+		addrs = &instr->ctx.addr.addrs[offset];
+
+		for (i = 0; i < naddrs; i++)
+			address |= (u64)addrs[i] << (8 * i);
+
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_ADDR,
+					    address);
+		/*0 - 1 byte of address, 1 - 2 bytes of address ...*/
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_ADDR_SIZE,
+					    naddrs - 1);
+		break;
+
+	case NAND_OP_DATA_OUT_INSTR:
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_DIR,
+					    GCMD_DIR_WRITE);
+
+	case NAND_OP_DATA_IN_INSTR:
+		is_data_instr = true;
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+					    GCMD_LAY_INSTR_DATA);
+
+		len = nand_subop_get_data_len(subop, op_id);
+		offset = nand_subop_get_data_start_off(subop, op_id);
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_SECT_CNT, 1);
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_LAST_SIZE, len);
+		if (instr->ctx.data.force_8bit) {
+			ret = cadence_nand_force_byte_access(chip, true);
+			if (ret)
+				return ret;
+		}
+
+		break;
+
+	default:
+		/* This should never happen */
+		break;
+	}
+
+	ret = cadence_nand_generic_cmd_send(cdns_nand, thread_nr,
+					    mini_ctrl_cmd, 0);
+	if (ret) {
+		dev_err(cdns_nand->dev, "send cmd failed\n");
+		return ret;
+	}
+
+	if (!is_data_instr)
+		return 0;
+
+	/* transfer data using slave DMA interface */
+	if (instr->type == NAND_OP_DATA_IN_INSTR) {
+		void *buf = instr->ctx.data.buf.in + offset;
+
+		ret = cadence_nand_read_buf(cdns_nand, buf, len);
+	} else {
+		const void *buf = instr->ctx.data.buf.out + offset;
+
+		ret = cadence_nand_write_buf(cdns_nand, buf, len);
+	}
+
+	if (ret)
+		return ret;
+
+	if (instr->ctx.data.force_8bit) {
+		ret = cadence_nand_force_byte_access(chip, false);
+		if (ret) {
+			dev_err(cdns_nand->dev, "s\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int cadence_nand_waitrdy(struct nand_chip *chip,
+				const struct nand_subop *subop)
+{
+	int status;
+	unsigned int op_id = 0;
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+	const struct nand_op_instr *instr = &subop->instrs[op_id];
+
+	status = wait_for_rb_ready(cdns_nand, instr->ctx.waitrdy.timeout_ms);
+
+	return status;
+}
+
+static int cadence_nand_ooblayout_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobregion)
+{
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = cdns_nand->bbm_len;
+	oobregion->length = cdns_nand->avail_oob_size
+		- cdns_nand->bbm_len;
+
+	return 0;
+}
+
+static int cadence_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = cdns_nand->avail_oob_size;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops cadence_nand_ooblayout_ops = {
+	.free = cadence_nand_ooblayout_free,
+	.ecc = cadence_nand_ooblayout_ecc,
+};
+
+static int calc_cycl(u32 timing, u32 clock)
+{
+	if (timing == 0 || clock == 0)
+		return 0;
+
+	if ((timing % clock) > 0)
+		return timing / clock;
+	else
+		return timing / clock - 1;
+}
+
+static int
+cadence_nand_setup_data_interface(struct nand_chip *chip, int chipnr,
+				  const struct nand_data_interface *conf)
+{
+	const struct nand_sdr_timings *sdr;
+	struct cdns_nand_info *cdns_nand = chip_to_cdns_nand_info(chip);
+
+	u32 reg;
+	u32 board_delay = cdns_nand->board_delay;
+	u32 sdr_clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+						cdns_nand->nf_clk_rate);
+	u32 nand2_delay = cdns_nand->nand2_delay;
+	u32 tceh_cnt;
+	u32 tcs_cnt;
+	u32 tadl_cnt;
+	u32 tcad = 0;
+	u32 tccs_cnt;
+	u32 tcdqsh = 0;
+	u32 tcdqss = 0;
+	u32 tckwr = 0;
+	u32 tcr_cnt, tcr = 0;
+	u32 tcres = 0;
+	u32 tfeat_cnt;
+	u32 tpre =	0;
+	u32 tpsth = 0;
+	u32 trhw_cnt;
+	u32 trhz_cnt;
+	u32 trpst = 0;
+	u32 tvdly = 0;
+	u32 twb_cnt;
+	u32 twh_cnt = 0;
+	u32 twhr_cnt;
+	u32 twpst = 0;
+	u32 twrck = 0;
+	u32 tcals = 0;
+	u32 tcwaw = 0;
+	u32 twp_cnt = 0;
+
+	u32 if_skew = cdns_nand->if_skew;
+
+	u8 cadence_nand_phy_dll_aging = cdns_nand->caps.phy_dll_aging;
+	u8 cadence_nand_phy_per_bit_deskew =
+		cdns_nand->caps.phy_per_bit_deskew;
+
+	u32 board_delay_with_skew_min = board_delay - if_skew;
+	u32 board_delay_with_skew_max = board_delay + if_skew;
+	u32 dqs_sampl_res;
+	u32 phony_dqs_mod;
+	u32 phony_dqs_comb_delay;
+	u32 trp_cnt = 0, trh_cnt = 0;
+	u32 tdvw, tdvw_min, tdvw_max;
+	u32 extended_read_mode;
+	u32 extended_wr_mode;
+	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
+	u32 tcwaw_cnt;
+	u32 tvdly_cnt;
+
+	u32 cadence_nand_is_phy_type_dll = 0;
+
+	reg =  readl(cdns_nand->reg + CTRL_FEATURES);
+	if (reg & (CTRL_FEATURES_NVDDR_2_3
+		   | CTRL_FEATURES_NVDDR))
+		cadence_nand_is_phy_type_dll = 1;
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	//------------------------------------------------------------------
+	// sampling point calculation
+	//------------------------------------------------------------------
+	if (cadence_nand_is_phy_type_dll) {
+		dqs_sampl_res = sdr_clk_period / 2;
+		phony_dqs_mod = 2;//for DLL phy
+		if (cadence_nand_phy_dll_aging) {
+			if (cadence_nand_phy_per_bit_deskew)
+				phony_dqs_comb_delay = 6 * nand2_delay;
+			else
+				phony_dqs_comb_delay = 5 * nand2_delay;
+		} else {
+			if (cadence_nand_phy_per_bit_deskew)
+				phony_dqs_comb_delay = 5 * nand2_delay;
+			else
+				phony_dqs_comb_delay = 4 * nand2_delay;
+		}
+
+	} else {
+		dqs_sampl_res = sdr_clk_period;//for async phy
+		phony_dqs_mod = 1;//for async phy
+		phony_dqs_comb_delay = 0;
+	}
+
+	tdvw_min = sdr->tREA_max + board_delay_with_skew_max
+		+ phony_dqs_comb_delay;
+	/*
+	 * the idea of those calculation is to get the optimum value
+	 * for tRP and tRH timings if it is NOT possible to sample data
+	 * with optimal tRP/tRH settings the parameters will be extended
+	 */
+	if (sdr->tRC_min <= sdr_clk_period &&
+	    sdr->tRP_min <= (sdr_clk_period / 2) &&
+	    sdr->tREH_min <= (sdr_clk_period / 2)) {
+		//performance mode
+		tdvw = sdr->tRHOH_min + sdr_clk_period / 2 - sdr->tREA_max;
+		tdvw_max = sdr_clk_period / 2 + sdr->tRHOH_min
+			+ board_delay_with_skew_min - phony_dqs_comb_delay;
+		/* check if data valid window and sampling point can be found
+		 * and is not on the edge (ie. we have hold margin)
+		 * if not extend the tRP timings
+		 */
+		if (tdvw > 0) {
+			if (tdvw_max > tdvw_min &&
+			    (tdvw_max % dqs_sampl_res) > 0) {
+				/* there is valid sampling point so
+				 * extended mode is allowed
+				 */
+				extended_read_mode = 0;
+			} else {
+				/* no valid sampling point so the RE pulse
+				 * need to be widen widening by half clock
+				 * cycle should be sufficient
+				 * to find sampling point
+				 */
+				extended_read_mode = 1;
+				tdvw_max = sdr_clk_period + sdr->tRHOH_min
+					+ board_delay_with_skew_min
+					- phony_dqs_comb_delay;
+			}
+		} else {
+			//there is no valid window
+			//to be able to sample data the tRP need to be widen
+			//very safe calculations are performed here
+			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
+				   + dqs_sampl_res) / sdr_clk_period;
+			extended_read_mode = 1;
+			tdvw_max = (trp_cnt + 1) * sdr_clk_period
+				+ sdr->tRHOH_min
+				+ board_delay_with_skew_min
+				- phony_dqs_comb_delay;
+		}
+
+	} else {
+		//extended read mode
+		extended_read_mode = 1;
+		trp_cnt = calc_cycl(sdr->tRP_min, sdr_clk_period);
+		if (sdr->tREH_min >= (sdr->tRC_min - ((trp_cnt + 1)
+						      * sdr_clk_period))) {
+			trh_cnt = calc_cycl(sdr->tREH_min, sdr_clk_period);
+		} else {
+			trh_cnt = calc_cycl((sdr->tRC_min
+					     - ((trp_cnt + 1)
+						* sdr_clk_period)),
+					    sdr_clk_period);
+		}
+
+		tdvw = sdr->tRHOH_min + ((trp_cnt + 1) * sdr_clk_period)
+			- sdr->tREA_max;
+		/* check if data valid window and sampling point can be found
+		 * or if it is at the edge check if previous is valid
+		 * - if not extend the tRP timings
+		 */
+		if (tdvw > 0) {
+			tdvw_max = (trp_cnt + 1) * sdr_clk_period
+				+ sdr->tRHOH_min
+				+ board_delay_with_skew_min
+				- phony_dqs_comb_delay;
+			if ((((tdvw_max / dqs_sampl_res)
+			      * dqs_sampl_res) <= tdvw_min) ||
+			    (((tdvw_max % dqs_sampl_res) == 0) &&
+			     (((tdvw_max / dqs_sampl_res - 1)
+			       * dqs_sampl_res) <= tdvw_min))) {
+				/* data valid window width is lower than
+				 * sampling resolution and do not hit any
+				 * sampling point to be sure the sampling point
+				 * will be found the RE low pulse width will be
+				 *  extended by one clock cycle
+				 */
+				trp_cnt = trp_cnt + 1;
+				tdvw_max = (trp_cnt + 1) * sdr_clk_period
+					+ sdr->tRHOH_min
+					+ board_delay_with_skew_min
+					- phony_dqs_comb_delay;
+			}
+		} else {
+			/* there is no valid window
+			 * to be able to sample data the tRP need to be widen
+			 * very safe calculations are performed here
+			 */
+			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
+				   + dqs_sampl_res) / sdr_clk_period;
+			tdvw_max = (trp_cnt + 1) * sdr_clk_period
+				+ sdr->tRHOH_min + board_delay_with_skew_min
+				- phony_dqs_comb_delay;
+		}
+	}
+
+	if (cadence_nand_is_phy_type_dll) {
+		u32 tpre_cnt = calc_cycl(tpre, sdr_clk_period);
+		u32 tcdqss_cnt = calc_cycl(tcdqss + if_skew,
+						sdr_clk_period);
+		u32 tpsth_cnt = calc_cycl(tpsth + if_skew, sdr_clk_period);
+
+		u32 trpst_cnt = calc_cycl(trpst + if_skew, sdr_clk_period)
+			+ 1;
+		u32 twpst_cnt = calc_cycl(twpst + if_skew, sdr_clk_period)
+			+ 1;
+		u32 tcres_cnt = calc_cycl(tcres + if_skew, sdr_clk_period)
+			+ 1;
+		u32 tcdqsh_cnt = calc_cycl(tcdqsh + if_skew,
+						sdr_clk_period) + 5;
+
+		//toggle_timings_0 - tCR,tPRE,tCDQSS,tPSTH
+		tcr_cnt = calc_cycl(tcr + if_skew, sdr_clk_period);
+		/* skew not included because this timing defines duration of
+		 * RE or DQS before data transfer
+		 */
+		tpsth_cnt = tpsth_cnt + 1;
+		reg  = 0;
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPSTH, tpsth_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCDQSS, tcdqss_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPRE, tpre_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCR, tcr_cnt);
+		writel(reg, cdns_nand->reg + TOGGLE_TIMINGS0);
+		dev_dbg(cdns_nand->dev, "TOGGLE_TIMINGS_0_SDR\t%x\n", reg);
+
+		//toggle_timings_1 - tRPST,tWPST
+		reg  = 0;
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCDQSH, tcdqsh_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCRES, tcres_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TRPST, trpst_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TWPST, twpst_cnt);
+		writel(reg, cdns_nand->reg + TOGGLE_TIMINGS1);
+		dev_dbg(cdns_nand->dev, "TOGGLE_TIMINGS_1_SDR\t%x\n", reg);
+	}
+
+	//async_toggle_timings - tRH,tRP,tWH,tWP
+	if (sdr->tWC_min <= sdr_clk_period &&
+	    (sdr->tWP_min + if_skew) <= (sdr_clk_period / 2) &&
+	    (sdr->tWH_min + if_skew) <= (sdr_clk_period / 2)) {
+		extended_wr_mode = 0;
+	} else {
+		extended_wr_mode = 1;
+		twp_cnt = calc_cycl(sdr->tWP_min + if_skew, sdr_clk_period);
+		if ((twp_cnt + 1) * sdr_clk_period < (tcals + if_skew))
+			twp_cnt = calc_cycl(tcals + if_skew, sdr_clk_period);
+
+		if (sdr->tWH_min >= (sdr->tWC_min - ((twp_cnt + 1)
+						     * sdr_clk_period))) {
+			twh_cnt = calc_cycl(sdr->tWH_min + if_skew,
+					    sdr_clk_period);
+		} else {
+			twh_cnt = calc_cycl((sdr->tWC_min
+					     - (twp_cnt + 1) * sdr_clk_period)
+					    + if_skew, sdr_clk_period);
+		}
+	}
+
+	reg  = 0;
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRH, trh_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRP, trp_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWH, twh_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWP, twp_cnt);
+	writel(reg, cdns_nand->reg + ASYNC_TOGGLE_TIMINGS);
+	dev_dbg(cdns_nand->dev, "ASYNC_TOGGLE_TIMINGS_SDR\t%x\n", reg);
+
+	if (cadence_nand_is_phy_type_dll) {
+		/* sync_timings - tCKWR,tWRCK,tCAD
+		 * sync timing are related to the clock so the skew
+		 * is minor and do not need to be included into calculations
+		 */
+		u32 tckwr_cnt = calc_cycl(tckwr, sdr_clk_period);
+		u32 twrck_cnt = calc_cycl(twrck, sdr_clk_period);
+		u32 tcad_cnt = calc_cycl(tcad, sdr_clk_period);
+
+		reg  = 0;
+		reg |= FIELD_PREP(SYNC_TIMINGS_TCKWR, tckwr_cnt);
+		reg |= FIELD_PREP(SYNC_TIMINGS_TWRCK, twrck_cnt);
+		reg |= FIELD_PREP(SYNC_TIMINGS_TCAD, tcad_cnt);
+		writel(reg, cdns_nand->reg + SYNC_TIMINGS);
+		dev_dbg(cdns_nand->dev, "SYNC_TIMINGS_SDR\t%x\n", reg);
+	}
+
+	//timings0 - tadl,tccs,twhr,trhw
+	tadl_cnt = calc_cycl((sdr->tADL_min + if_skew), sdr_clk_period);
+	tccs_cnt = calc_cycl((sdr->tCCS_min + if_skew), sdr_clk_period);
+	twhr_cnt = calc_cycl((sdr->tWHR_min + if_skew), sdr_clk_period);
+	trhw_cnt = calc_cycl((sdr->tRHW_min + if_skew), sdr_clk_period);
+	reg  = 0;
+	reg |= FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
+
+	/* if timing exceeds delay field in timing register
+	 * then use maximum value
+	 */
+	if (FIELD_FIT(TIMINGS0_TCCS, tccs_cnt))
+		reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
+	else
+		reg |= TIMINGS0_TCCS;
+
+	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
+	writel(reg, cdns_nand->reg + TIMINGS0);
+	dev_dbg(cdns_nand->dev, "TIMINGS0_SDR\t%x\n", reg);
+
+	//timings1 - trhz,twb,tcwaw,tvdly
+	//the following is related to single signal so skew is not needed
+	trhz_cnt = calc_cycl(sdr->tRHZ_max, sdr_clk_period);
+	trhz_cnt = trhz_cnt + 1;
+	twb_cnt = calc_cycl((sdr->tWB_max + board_delay), sdr_clk_period);
+	/* because of the two stage syncflop the value must be increased by 3
+	 * first value is related with sync, second value is related
+	 * with output if delay
+	 */
+	twb_cnt = twb_cnt + 3 + 5;
+	/* the following is related to the we edge of the random data input
+	 * sequence so skew is not needed
+	 */
+	tcwaw_cnt = calc_cycl(tcwaw, sdr_clk_period);
+	tvdly_cnt = calc_cycl((tvdly + if_skew), sdr_clk_period);
+	reg  = 0;
+	reg |= FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TWB, twb_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
+	writel(reg, cdns_nand->reg + TIMINGS1);
+	dev_dbg(cdns_nand->dev, "TIMINGS1_SDR\t%x\n", reg);
+
+	//timings2 - cs_hold_time,cs_setup_time
+	tfeat_cnt = calc_cycl(sdr->tFEAT_max, sdr_clk_period);
+	if (tfeat_cnt < twb_cnt)
+		tfeat_cnt = twb_cnt;
+
+	tceh_cnt = calc_cycl(sdr->tCEH_min, sdr_clk_period);
+	tcs_cnt = calc_cycl((sdr->tCS_min + if_skew), sdr_clk_period);
+
+	reg  = 0;
+	reg |= FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
+	writel(reg, cdns_nand->reg + TIMINGS2);
+	dev_dbg(cdns_nand->dev, "TIMINGS2_SDR\t%x\n", reg);
+
+	if (cadence_nand_is_phy_type_dll) {
+		reg = DLL_PHY_CTRL_DLL_RST_N;
+		if (extended_wr_mode)
+			reg |= DLL_PHY_CTRL_EXTENDED_WR_MODE;
+		if (extended_read_mode)
+			reg |= DLL_PHY_CTRL_EXTENDED_RD_MODE;
+
+		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, 7);
+		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, 7);
+		writel(reg, cdns_nand->reg + DLL_PHY_CTRL);
+		dev_dbg(cdns_nand->dev, "DLL_PHY_CTRL_SDR\t%x\n", reg);
+	}
+
+	/* ------------------------------------------------------------------
+	 * sampling point calculation
+	 * ------------------------------------------------------------------
+	 */
+	if ((tdvw_max % dqs_sampl_res) > 0) {
+		// sampling point has margin to the edge of data
+		if (((tdvw_max / dqs_sampl_res) * dqs_sampl_res) > tdvw_min) {
+			/* if "number" of sampling point is:
+			 * - even then phony_dqs_sel 0
+			 * - odd then phony_dqs_sel 1
+			 */
+			if (((tdvw_max / dqs_sampl_res) % 2) > 0) {
+				//odd
+				dll_phy_dqs_timing = 0x00110004;
+				phony_dqs_timing = tdvw_max
+					/ (dqs_sampl_res * phony_dqs_mod);
+				if (!cadence_nand_is_phy_type_dll)
+					phony_dqs_timing--;
+
+				rd_del_sel = phony_dqs_timing + 3;
+			} else {
+				//even
+				dll_phy_dqs_timing = 0x00100004;
+				phony_dqs_timing = tdvw_max
+					/ (dqs_sampl_res * phony_dqs_mod);
+				phony_dqs_timing--;
+				rd_del_sel = phony_dqs_timing + 3;
+			}
+		} else {
+			dev_warn(cdns_nand->dev,
+				 "ERROR0 : cannot find valid sampling point\n");
+		}
+	} else {
+		/* sampling point is at the edge of data
+		 * check if earlier sampling point is valid for min data valid
+		 * window
+		 */
+		if ((tdvw_max / dqs_sampl_res - 1) * dqs_sampl_res > tdvw_min) {
+			/* if "number" of sampling point is:
+			 * - even then phony_dqs_sel 0
+			 * - odd then phony_dqs_sel 1
+			 */
+			if (((tdvw_max / dqs_sampl_res - 1) % 2) > 0) {
+				//odd
+				dll_phy_dqs_timing = 0x00110004;
+				phony_dqs_timing = tdvw_max
+					/ (dqs_sampl_res * phony_dqs_mod) - 1;
+				if (!cadence_nand_is_phy_type_dll)
+					phony_dqs_timing--;
+
+				rd_del_sel = phony_dqs_timing + 3;
+			} else {
+				//even
+				dll_phy_dqs_timing = 0x00100004;
+				phony_dqs_timing = (tdvw_max
+						    / dqs_sampl_res - 1)
+					/ phony_dqs_mod;
+				phony_dqs_timing--;
+				rd_del_sel = phony_dqs_timing + 3;
+			}
+		} else {
+			dev_warn(cdns_nand->dev,
+				 "ERROR1 : cannot find valid sampling point\n");
+		}
+	}
+
+	reg = 0;
+	reg |= FIELD_PREP(PHY_CTRL_PHONY_DQS, phony_dqs_timing);
+	if (cadence_nand_is_phy_type_dll)
+		reg  |= PHY_CTRL_SDR_DQS;
+	writel(reg, cdns_nand->reg + PHY_CTRL);
+	dev_dbg(cdns_nand->dev, "PHY_CTRL_REG_SDR\t%x\n", reg);
+
+	if (cadence_nand_is_phy_type_dll) {
+		dev_dbg(cdns_nand->dev, "PHY_TSEL_REG_SDR\t%x\n", 0);
+		writel(0, cdns_nand->reg + PHY_TSEL);
+
+		dev_dbg(cdns_nand->dev, "PHY_DQ_TIMING_REG_SDR\t%x\n", 2);
+		writel(2, cdns_nand->reg + PHY_DQ_TIMING);
+
+		dev_dbg(cdns_nand->dev, "PHY_DQS_TIMING_REG_SDR\t%x\n",
+			dll_phy_dqs_timing);
+		writel(dll_phy_dqs_timing, cdns_nand->reg + PHY_DQS_TIMING);
+
+		reg = 0;
+		reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
+		dev_dbg(cdns_nand->dev, "PHY_GATE_LPBK_CTRL_REG_SDR\t%x\n",
+			reg);
+		writel(reg, cdns_nand->reg + PHY_GATE_LPBK_CTRL);
+
+		dev_dbg(cdns_nand->dev, "PHY_DLL_MASTER_CTRL_REG_SDR\t%lx\n",
+			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
+		writel(PHY_DLL_MASTER_CTRL_BYPASS_MODE,
+		       cdns_nand->reg + PHY_DLL_MASTER_CTRL);
+		dev_dbg(cdns_nand->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
+		writel(0, cdns_nand->reg + PHY_DLL_SLAVE_CTRL);
+	}
+
+	return 0;
+}
+
+int cadence_nand_attach_chip(struct nand_chip *chip)
+{
+	int ret = 0;
+	u32 max_oob_data_size;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cdns_nand_info *cdns_nand = mtd_cdns_nand_info(mtd);
+
+	if (chip->options & NAND_BUSWIDTH_16) {
+		ret = cadence_nand_set_access_width(cdns_nand, 16);
+		if (ret)
+			goto free_buf;
+	}
+
+	cdns_nand->chip.bbt_options |= NAND_BBT_USE_FLASH;
+	cdns_nand->chip.bbt_options |= NAND_BBT_NO_OOB;
+	cdns_nand->chip.ecc.mode = NAND_ECC_HW;
+
+	cdns_nand->chip.options |= NAND_NO_SUBPAGE_WRITE;
+
+	cdns_nand->bbm_offs = cdns_nand->chip.badblockpos;
+	if (cdns_nand->chip.options & NAND_BUSWIDTH_16) {
+		cdns_nand->bbm_offs &= ~0x01;
+		cdns_nand->bbm_len = 2;
+	} else {
+		cdns_nand->bbm_len = 1;
+	}
+
+	ret = nand_ecc_choose_conf(&cdns_nand->chip,
+				   &cdns_nand->ecc_caps,
+				   mtd->oobsize - cdns_nand->bbm_len);
+	if (ret) {
+		dev_err(cdns_nand->dev, "ECC configuration failed\n");
+		goto free_buf;
+	}
+
+	dev_dbg(cdns_nand->dev,
+		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
+		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
+
+	/* Error correction */
+	cdns_nand->main_size = mtd->writesize;
+	cdns_nand->sector_size = cdns_nand->chip.ecc.size;
+	cdns_nand->sector_count = cdns_nand->main_size / cdns_nand->sector_size;
+	cdns_nand->oob_size = mtd->oobsize;
+	cdns_nand->avail_oob_size = cdns_nand->oob_size
+		- cdns_nand->sector_count * cdns_nand->chip.ecc.bytes;
+
+	max_oob_data_size = MAX_OOB_SIZE_PER_SECTOR;
+
+	if (cdns_nand->avail_oob_size > max_oob_data_size)
+		cdns_nand->avail_oob_size = max_oob_data_size;
+
+	if ((cdns_nand->avail_oob_size + cdns_nand->bbm_len
+	     + cdns_nand->sector_count
+	     * cdns_nand->chip.ecc.bytes) > mtd->oobsize)
+		cdns_nand->avail_oob_size -= 4;
+
+	cadence_nand_set_ecc_strength(cdns_nand, chip->ecc.strength);
+	cadence_nand_set_ecc_enable(cdns_nand, true);
+	cadence_nand_set_erase_detection(cdns_nand, true, chip->ecc.strength);
+
+	/* override the default read operations */
+	cdns_nand->chip.ecc.read_page = cadence_nand_read_page;
+	cdns_nand->chip.ecc.read_page_raw = cadence_nand_read_page_raw;
+	cdns_nand->chip.ecc.write_page = cadence_nand_write_page;
+	cdns_nand->chip.ecc.write_page_raw = cadence_nand_write_page_raw;
+	cdns_nand->chip.ecc.read_oob = cadence_nand_read_oob;
+	cdns_nand->chip.ecc.write_oob = cadence_nand_write_oob;
+	cdns_nand->chip.ecc.read_oob_raw = cadence_nand_read_oob_raw;
+	cdns_nand->chip.ecc.write_oob_raw = cadence_nand_write_oob_raw;
+
+	kfree(cdns_nand->buf);
+	cdns_nand->buf = kzalloc(mtd->writesize + mtd->oobsize,
+				 GFP_KERNEL);
+	if (!cdns_nand->buf) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	/* Is 32-bit DMA supported? */
+	ret = dma_set_mask(cdns_nand->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(cdns_nand->dev, "no usable DMA configuration\n");
+		goto free_buf;
+	}
+
+	mtd_set_ooblayout(mtd, &cadence_nand_ooblayout_ops);
+
+	return 0;
+
+free_buf:
+	kfree(cdns_nand->buf);
+
+	return ret;
+}
+
+static const struct nand_controller_ops cadence_nand_controller_ops = {
+	.attach_chip = cadence_nand_attach_chip,
+	.exec_op = cadence_nand_exec_op,
+	.setup_data_interface = cadence_nand_setup_data_interface,
+};
+
+int cadence_nand_init(struct cdns_nand_info *cdns_nand)
+{
+	dma_cap_mask_t mask;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	int ret = 0;
+
+	chip = &cdns_nand->chip;
+	mtd = nand_to_mtd(chip);
+
+	mtd->owner = THIS_MODULE;
+	mtd->dev.parent = cdns_nand->dev;
+	nand_set_flash_node(chip, cdns_nand->dev->of_node);
+	if (!mtd->name)
+		mtd->name = CADENCE_NAND_NAME;
+
+	cdns_nand->cdma_desc = dma_alloc_coherent(cdns_nand->dev,
+						  sizeof(*cdns_nand->cdma_desc),
+						  &cdns_nand->dma_cdma_desc,
+						  GFP_KERNEL);
+	if (!cdns_nand->dma_cdma_desc)
+		return -ENOMEM;
+
+	cdns_nand->buf = kmalloc(16 * 1024, GFP_KERNEL);
+	if (!cdns_nand->buf) {
+		goto free_buf_desc;
+		ret = -ENOMEM;
+	}
+
+	if (request_irq(cdns_nand->irq, cadence_nand_isr, IRQF_SHARED,
+			CADENCE_NAND_NAME, cdns_nand)) {
+		dev_err(cdns_nand->dev, "Unable to allocate IRQ\n");
+		ret = -ENODEV;
+		goto free_buf;
+	}
+
+	/* register the driver with the NAND core subsystem */
+	cdns_nand->chip.legacy.block_markbad = cadence_nand_block_markbad;
+
+	spin_lock_init(&cdns_nand->irq_lock);
+	init_completion(&cdns_nand->complete);
+
+	ret = cadence_nand_hw_init(cdns_nand);
+	if (ret)
+		goto disable_irq;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	if (cdns_nand->caps.has_dma) {
+		cdns_nand->dmac = dma_request_channel(mask, NULL, NULL);
+		if (!cdns_nand->dmac) {
+			dev_err(cdns_nand->dev,
+				"Unable to get a dma channel\n");
+			ret = -EBUSY;
+			goto disable_irq;
+		}
+	}
+
+	chip->legacy.dummy_controller.ops = &cadence_nand_controller_ops;
+	if (nand_scan(&cdns_nand->chip, cdns_nand->caps.max_banks)) {
+		ret = -ENXIO;
+		goto dma_release_chnl;
+	}
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(cdns_nand->dev, "Failed to register MTD: %d\n",
+			ret);
+		goto cleanup_nand;
+	}
+
+	return 0;
+
+cleanup_nand:
+	nand_cleanup(chip);
+
+dma_release_chnl:
+	if (cdns_nand->dmac)
+		dma_release_channel(cdns_nand->dmac);
+
+disable_irq:
+	cadence_nand_irq_cleanup(cdns_nand->irq, cdns_nand);
+
+free_buf:
+	kfree(cdns_nand->buf);
+
+free_buf_desc:
+	dma_free_coherent(cdns_nand->dev, sizeof(struct cadence_nand_cdma_desc),
+			  cdns_nand->cdma_desc, cdns_nand->dma_cdma_desc);
+
+	return ret;
+}
+
+/* driver exit point */
+void cadence_nand_remove(struct cdns_nand_info *cdns_nand)
+{
+	nand_release(&cdns_nand->chip);
+	cadence_nand_irq_cleanup(cdns_nand->irq, cdns_nand);
+	kfree(cdns_nand->buf);
+	dma_free_coherent(cdns_nand->dev, sizeof(struct cadence_nand_cdma_desc),
+			  cdns_nand->cdma_desc, cdns_nand->dma_cdma_desc);
+
+	if (cdns_nand->dmac)
+		dma_release_channel(cdns_nand->dmac);
+}
+
+struct cadence_nand_dt_devdata {
+	/* is aging feature in the DLL PHY supported */
+	u8 phy_dll_aging;
+	/* is per bit deskew for read and write path in the PHY supported */
+	u8 phy_per_bit_deskew;
+	/* use DMA interface for generic commands */
+	u8 has_dma;
+};
+
+struct cadence_nand_dt {
+	struct cdns_nand_info cdns_nand;
+	struct clk *clk;
+};
+
+static const struct cadence_nand_dt_devdata cadnence_nand_default = {
+	.phy_dll_aging = 1,
+	.phy_per_bit_deskew = 1,
+	.has_dma = 1,
+};
+
+static const struct of_device_id cadence_nand_dt_ids[] = {
+	{
+		.compatible = "cdns,hpnfc-nand",
+		.data = &cadnence_nand_default
+	}, {/* cadence */}
+};
+
+MODULE_DEVICE_TABLE(of, cadence_nand_dt_ids);
+
+static void cadence_nand_dt_read_properties(struct cdns_nand_info *cdns_nand,
+					    struct device_node *np)
+{
+	u32 val;
+	int ret;
+
+	ret = of_property_read_u32(np, "cdns,if-skew", &val);
+	if (ret) {
+		dev_warn(cdns_nand->dev, "missing cdns,if-skew property\n");
+		val = 0;
+	}
+	cdns_nand->if_skew = val;
+
+	ret = of_property_read_u32(np, "cdns,nand2-delay", &val);
+	if (ret) {
+		dev_warn(cdns_nand->dev, "missing cdns,nand2-delay property\n");
+		val = 0;
+	}
+	cdns_nand->nand2_delay = val;
+
+	ret = of_property_read_u32(np, "cdns,board-delay", &val);
+	if (ret) {
+		dev_warn(cdns_nand->dev, "missing cdns,board-delay property\n");
+		val = 0;
+	}
+	cdns_nand->board_delay = val;
+}
+
+static int cadence_nand_dt_probe(struct platform_device *ofdev)
+{
+	struct resource *res;
+	struct cadence_nand_dt *dt;
+	struct cdns_nand_info *cdns_nand;
+	int ret;
+	const struct of_device_id *of_id;
+	const struct cadence_nand_dt_devdata *devdata;
+
+	of_id = of_match_device(cadence_nand_dt_ids, &ofdev->dev);
+	if (of_id) {
+		ofdev->id_entry = of_id->data;
+		devdata = of_id->data;
+	} else {
+		pr_err("Failed to find the right device id.\n");
+		return -ENOMEM;
+	}
+
+	dt = devm_kzalloc(&ofdev->dev, sizeof(*dt), GFP_KERNEL);
+	if (!dt)
+		return -ENOMEM;
+
+	cdns_nand = &dt->cdns_nand;
+	cdns_nand->caps.phy_dll_aging = devdata->phy_dll_aging;
+	cdns_nand->caps.phy_per_bit_deskew = devdata->phy_per_bit_deskew;
+	cdns_nand->caps.has_dma = devdata->has_dma;
+
+	cdns_nand->dev = &ofdev->dev;
+	cdns_nand->irq = platform_get_irq(ofdev, 0);
+	if (cdns_nand->irq < 0) {
+		dev_err(&ofdev->dev, "no irq defined\n");
+		return cdns_nand->irq;
+	}
+	dev_info(cdns_nand->dev, "IRQ: nr %d\n", cdns_nand->irq);
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	cdns_nand->reg = devm_ioremap_resource(cdns_nand->dev, res);
+	if (IS_ERR(cdns_nand->reg)) {
+		dev_err(&ofdev->dev, "devm_ioremap_resource res 0 failed\n");
+		return PTR_ERR(cdns_nand->reg);
+	}
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	cdns_nand->io.dma = res->start;
+	cdns_nand->io.virt = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(cdns_nand->io.virt)) {
+		dev_err(cdns_nand->dev, "devm_ioremap_resource res 1 failed\n");
+		return PTR_ERR(cdns_nand->io.virt);
+	}
+
+	dt->clk = devm_clk_get(cdns_nand->dev, "nf_clk");
+	if (IS_ERR(dt->clk))
+		return PTR_ERR(dt->clk);
+
+	cdns_nand->nf_clk_rate = clk_get_rate(dt->clk);
+
+	cadence_nand_dt_read_properties(cdns_nand, ofdev->dev.of_node);
+
+	ret = cadence_nand_init(cdns_nand);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(ofdev, dt);
+	return 0;
+}
+
+static int cadence_nand_dt_remove(struct platform_device *ofdev)
+{
+	struct cadence_nand_dt *dt = platform_get_drvdata(ofdev);
+
+	cadence_nand_remove(&dt->cdns_nand);
+
+	return 0;
+}
+
+static struct platform_driver cadence_nand_dt_driver = {
+	.probe		= cadence_nand_dt_probe,
+	.remove		= cadence_nand_dt_remove,
+	.driver		= {
+		.name	= "cadence-nand",
+		.of_match_table = cadence_nand_dt_ids,
+	},
+};
+
+module_platform_driver(cadence_nand_dt_driver);
+
+MODULE_AUTHOR("Piotr Sroka <piotrs@cadence.com>");
+MODULE_DESCRIPTION("Driver for Cadence NAND flash controller");
+
diff --git a/drivers/mtd/nand/raw/cadence_nand.h b/drivers/mtd/nand/raw/cadence_nand.h
new file mode 100644
index 000000000000..2ba907ad6e46
--- /dev/null
+++ b/drivers/mtd/nand/raw/cadence_nand.h
@@ -0,0 +1,631 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Cadence NAND flash controller driver
+ *
+ * Copyright (C) 2019 Cadence
+ */
+
+#ifndef __CADENCE_NAND_H__
+#define __CADENCE_NAND_H__
+
+#include <linux/mtd/nand.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/types.h>
+
+/***************************************************/
+/*  Register definition */
+/***************************************************/
+
+/* Command register 0.
+ * Writing data to this register will initiate a new transaction
+ * of the NF controller.
+ */
+#define CMD_REG0			0x0000
+/* command type field mask */
+#define		CMD_REG0_CT		GENMASK(31, 30)
+/* command type CDMA */
+#define		CMD_REG0_CT_CDMA	0uL
+/* command type PIO */
+#define		CMD_REG0_CT_PIO		1uL
+/* command type reset */
+#define		CMD_REG0_CT_RST		2uL
+/* command type generic */
+#define		CMD_REG0_CT_GEN		3uL
+/* command thread number field mask */
+#define		CMD_REG0_TN		GENMASK(27, 24)
+/* command code field mask */
+#define		CMD_REG0_PIO_CC		GENMASK(15, 0)
+/* command code - read page */
+#define		CMD_REG0_PIO_CC_RD	0x2200uL
+/* command code - write page */
+#define		CMD_REG0_PIO_CC_WR	0x2100uL
+/* command code - copy back */
+#define		CMD_REG0_PIO_CC_CPB	0x1200uL
+/* command code - reset */
+#define		CMD_REG0_PIO_CC_RST	0x1100uL
+/* command code - set feature */
+#define		CMD_REG0_PIO_CC_SF	0x0100uL
+/* command interrupt mask */
+#define		CMD_REG0_INT		BIT(20)
+
+/* PIO command - volume ID  */
+#define		CMD_REG0_VOL_ID		GENMASK(19, 16)
+
+/* Command register 1. */
+#define CMD_REG1			0x0004
+/* PIO command - bank number  */
+#	define CMD_REG1_BANK		GENMASK(25, 24)
+/* PIO command - set feature - feature address */
+#	define CMD_REG1_FADDR		GENMASK(15, 0)
+
+/* Command register 2 */
+#define CMD_REG2			0x0008
+/* Command register 3 */
+#define CMD_REG3			0x000C
+/* Pointer register to select which thread status will be selected. */
+#define CMD_STATUS_PTR			0x0010
+/* Command status register for selected thread */
+#define CMD_STATUS			0x0014
+
+/* interrupt status register */
+#define INTR_STATUS			0x0110
+#define		INTR_STATUS_SDMA_ERR	BIT(22)
+#define		INTR_STATUS_SDMA_TRIGG	BIT(21)
+#define		INTR_STATUS_UNSUPP_CMD	BIT(19)
+#define		INTR_STATUS_DDMA_TERR	BIT(18)
+#define		INTR_STATUS_CDMA_TERR	BIT(17)
+#define		INTR_STATUS_CDMA_IDL	BIT(16)
+
+/* interrupt enable register */
+#define INTR_ENABLE				0x0114
+#define		INTR_ENABLE_INTR_EN		BIT(31)
+#define		INTR_ENABLE_SDMA_ERR_EN		BIT(22)
+#define		INTR_ENABLE_SDMA_TRIGG_EN	BIT(21)
+#define		INTR_ENABLE_UNSUPP_CMD_EN	BIT(19)
+#define		INTR_ENABLE_DDMA_TERR_EN	BIT(18)
+#define		INTR_ENABLE_CDMA_TERR_EN	BIT(17)
+#define		INTR_ENABLE_CDMA_IDLE_EN	BIT(16)
+
+/* Controller internal state */
+#define CTRL_STATUS				0x0118
+#define		CTRL_STATUS_INIT_COMP		BIT(9)
+#define		CTRL_STATUS_CTRL_BUSY		BIT(8)
+
+/* Command Engine threads state */
+#define TRD_STATUS				0x0120
+
+/*  Command Engine interrupt thread error status */
+#define TRD_ERR_INT_STATUS			0x0128
+/*  Command Engine interrupt thread error enable */
+#define TRD_ERR_INT_STATUS_EN			0x0130
+/*  Command Engine interrupt thread complete status*/
+#define TRD_COMP_INT_STATUS			0x0138
+
+/* Transfer config 0 register.
+ * Configures data transfer parameters.
+ */
+#define TRAN_CFG_0			        0x0400
+/* Offset value from the beginning of the page  */
+#define		TRAN_CFG_0_OFFSET	        GENMASK(31, 16)
+/* Numbers of sectors to transfer within single NF device's page.  */
+#define		TRAN_CFG_0_SEC_CNT	        GENMASK(7, 0)
+
+/* Transfer config 1 register.
+ * Configures data transfer parameters.
+ */
+#define TRAN_CFG_1				0x0404
+/* Size of last data sector.  */
+#define		TRAN_CFG_1_LAST_SEC_SIZE	GENMASK(31, 16)
+/*  Size of not-last data sector. - last*/
+#define		TRAN_CFG_1_SECTOR_SIZE		GENMASK(15, 0)
+
+/* NF device layout. */
+#define NF_DEV_LAYOUT			        0x0424
+/* Bit in ROW address used for selecting of the LUN */
+#define		NF_DEV_LAYOUT_ROWAC		GENMASK(27, 24)
+/* The number of LUN presents in the device.  */
+#define		NF_DEV_LAYOUT_LN	        GENMASK(23, 20)
+/* Enables Multi LUN operations  */
+#define		NF_DEV_LAYOUT_LUN_EN		BIT(16)
+/* Pages Per Block - number of pages in a block  */
+#define		NF_DEV_LAYOUT_PPB	        GENMASK(15, 0)
+
+/* ECC engine configuration register 0. */
+#define ECC_CONFIG_0				0x0428
+/* Correction strength  */
+#define		ECC_CONFIG_0_CORR_STR		GENMASK(9, 8)
+/* Enables scrambler logic in the controller  */
+#define		ECC_CONFIG_0_SCRAMBLER_EN	BIT(2)
+/*  Enable erased pages detection mechanism  */
+#define		ECC_CONFIG_0_ERASE_DET_EN	BIT(1)
+/*  Enable controller ECC check bits generation and correction  */
+#define		ECC_CONFIG_0_ECC_EN		BIT(0)
+
+/* ECC engine configuration register 1. */
+#define ECC_CONFIG_1				0x042C
+
+/* Multiplane settings register */
+#define MULTIPLANE_CFG				0x0434
+/* Cache operation settings. */
+#define CACHE_CFG				0x0438
+
+/* DMA settings register */
+#define DMA_SETINGS				0x043C
+/* Enable SDMA error report on access unprepared slave DMA interface.  */
+#define		DMA_SETINGS_SDMA_ERR_RSP	BIT(17)
+/* Outstanding transaction enable  */
+#define		DMA_SETINGS_OTE			BIT(16)
+/* DMA burst selection  */
+#define		DMA_SETINGS_BURST_SEL		GENMASK(7, 0)
+
+/* Transferred data block size for the slave DMA module */
+#define SDMA_SIZE				0x0440
+
+/* Thread number associated with transferred data block
+ * for the slave DMA module
+ */
+#define SDMA_TRD_NUM				0x0444
+/* Thread number mask */
+#define		SDMA_TRD_NUM_SDMA_TRD		GENMASK(2, 0)
+
+#define CONTROL_DATA_CTRL			0x0494
+/* Thread number mask */
+#define		CONTROL_DATA_CTRL_SIZE		GENMASK(15, 0)
+
+#define CTRL_VERSION				0x800
+
+/* available hardware features of the controller */
+#define CTRL_FEATURES				0x804
+/* Support for NV-DDR2/3 work mode  */
+#define		CTRL_FEATURES_NVDDR_2_3		BIT(28)
+/* Support for NV-DDR work mode  */
+#define		CTRL_FEATURES_NVDDR		BIT(27)
+/* Support for asynchronous work mode  */
+#define		CTRL_FEATURES_ASYNC		BIT(26)
+/* Support for asynchronous work mode */
+#define		CTRL_FEATURES_N_BANKS		GENMASK(25, 24)
+/* Slave and Master DMA data width  */
+#define		CTRL_FEATURES_DMA_DWITH64	BIT(21)
+/* Availability of Control Data feature.*/
+#define		CTRL_FEATURES_CONTROL_DATA	BIT(10)
+/* number of threads available in the controller  */
+#define		CTRL_FEATURES_N_THREADS		GENMASK(2, 0)
+
+/* NAND Flash memory device ID information */
+#define MANUFACTURER_ID			        0x0808
+/* Device ID  */
+#define		MANUFACTURER_ID_DID		GENMASK(23, 16)
+/* Manufacturer ID  */
+#define		MANUFACTURER_ID_MID		GENMASK(7, 0)
+
+/* Device areas settings. */
+#define NF_DEV_AREAS				0x080c
+/* Spare area size in bytes for the NF device page  */
+#define		NF_DEV_AREAS_SPARE_SIZE		GENMASK(31, 16)
+/* Main area size in bytes for the NF device page */
+#define		NF_DEV_AREAS_MAIN_SIZE		GENMASK(15, 0)
+
+/* device parameters 1 register contains device signature */
+#define DEV_PARAMS_1				0x0814
+#define		DEV_PARAMS_1_READID_6		GENMASK(31, 24)
+#define		DEV_PARAMS_1_READID_5		GENMASK(23, 16)
+#define		DEV_PARAMS_1_READID_4		GENMASK(15, 8)
+#define		DEV_PARAMS_1_READID_3		GENMASK(7, 0)
+
+/* device parameters 0 register */
+#define DEV_PARAMS_0				0x0810
+/* device type mask */
+#define		DEV_PARAMS_0_DEV_TYPE		GENMASK(31, 30)
+/* device type - ONFI */
+#define		DEV_PARAMS_0_DEV_TYPE_ONFI	1
+/* device type - JEDEC */
+#define		DEV_PARAMS_0_DEV_TYPE_JEDEC	2
+/* device type - unknown */
+#define		DEV_PARAMS_0_DEV_TYPE_UNKNOWN	3
+/* Number of bits used to addressing planes  */
+#define		DEV_PARAMS_0_PLANE_ADDR		GENMASK(15, 8)
+/* Indicates the number of LUNS present */
+#define		DEV_PARAMS_0_NO_OF_LUNS		GENMASK(7, 0)
+
+/* Features and optional commands supported
+ * by the connected device
+ */
+#define DEV_FEATURES				0x0818
+
+/* Number of blocks per LUN present in the NF device. */
+#define DEV_BLOCKS_PER_LUN			0x081c
+
+/* Device revision version */
+#define DEV_REVISION				0x0820
+
+/*  Device Timing modes 0*/
+#define ONFI_TIME_MOD_0				0x0824
+/* SDR timing modes support  */
+#define		ONFI_TIME_MOD_0_SDR		GENMASK(15, 0)
+/* DDR timing modes support  */
+#define		ONFI_TIME_MOD_0_DDR		GENMASK(31, 16)
+
+/*  Device Timing modes 1*/
+#define ONFI_TIME_MOD_1			        0x0828
+/* DDR2 timing modes support  */
+#define		ONFI_TIME_MOD_1_DDR2		GENMASK(15, 0)
+/* DDR3 timing modes support  */
+#define		ONFI_TIME_MOD_1_DDR3		GENMASK(31, 16)
+
+/* BCH Engine identification register 0 - correction strengths. */
+#define BCH_CFG_0				0x838
+#define		BCH_CFG_0_CORR_CAP_0		GENMASK(7, 0)
+#define		BCH_CFG_0_CORR_CAP_1		GENMASK(15, 8)
+#define		BCH_CFG_0_CORR_CAP_2		GENMASK(23, 16)
+#define		BCH_CFG_0_CORR_CAP_3		GENMASK(31, 24)
+
+/* BCH Engine identification register 1 - correction strengths. */
+#define BCH_CFG_1				0x83C
+#define		BCH_CFG_1_CORR_CAP_4		GENMASK(7, 0)
+#define		BCH_CFG_1_CORR_CAP_5		GENMASK(15, 8)
+#define		BCH_CFG_1_CORR_CAP_6		GENMASK(23, 16)
+#define		BCH_CFG_1_CORR_CAP_7		GENMASK(31, 24)
+
+/* BCH Engine identification register 2 - sector sizes. */
+#define BCH_CFG_2				0x840
+#define		BCH_CFG_2_SECT_0		GENMASK(15, 0)
+#define		BCH_CFG_2_SECT_1		GENMASK(31, 16)
+
+/* BCH Engine identification register 3  */
+#define BCH_CFG_3				0x844
+
+/* Ready/Busy# line status */
+#define RBN_SETINGS				0x1004
+
+/*  Common settings */
+#define COMMON_SET				0x1008
+/* 16 bit device connected to the NAND Flash interface  */
+#define		COMMON_SET_DEVICE_16BIT		BIT(8)
+
+/* skip_bytes registers */
+#define SKIP_BYTES_CONF				0x100C
+#define		SKIP_BYTES_MARKER_VALUE		GENMASK(31, 16)
+#define		SKIP_BYTES_NUM_OF_BYTES		GENMASK(7, 0)
+
+#define SKIP_BYTES_OFFSET			0x1010
+#define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
+
+#define TOGGLE_TIMINGS0				0x1014
+#define		TOGGLE_TIMINGS0_TCR		GENMASK(29, 24)
+#define		TOGGLE_TIMINGS0_TPRE		GENMASK(21, 16)
+#define		TOGGLE_TIMINGS0_TCDQSS		GENMASK(13, 8)
+#define		TOGGLE_TIMINGS0_TPSTH		GENMASK(5, 0)
+
+#define TOGGLE_TIMINGS1				0x1018
+#define		TOGGLE_TIMINGS1_TCDQSH		GENMASK(29, 24)
+#define		TOGGLE_TIMINGS1_TCRES		GENMASK(21, 16)
+#define		TOGGLE_TIMINGS1_TRPST		GENMASK(13, 8)
+#define		TOGGLE_TIMINGS1_TWPST		GENMASK(5, 0)
+
+/* ToggleMode/NV-DDR2/NV-DDR3 and SDR timings configuration. */
+#define ASYNC_TOGGLE_TIMINGS			0x101c
+#define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
+#define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
+#define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
+#define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
+
+/* SourceSynchronous/NV-DDR timings configuration. */
+#define	SYNC_TIMINGS				0x1020
+#define		SYNC_TIMINGS_TCKWR		GENMASK(21, 16)
+#define		SYNC_TIMINGS_TWRCK		GENMASK(13, 8)
+#define		SYNC_TIMINGS_TCAD		GENMASK(5, 0)
+
+#define	TIMINGS0				0x1024
+#define		TIMINGS0_TADL		        GENMASK(31, 24)
+#define		TIMINGS0_TCCS		        GENMASK(23, 16)
+#define		TIMINGS0_TWHR		        GENMASK(15, 8)
+#define		TIMINGS0_TRHW		        GENMASK(7, 0)
+
+#define	TIMINGS1				0x1028
+#define		TIMINGS1_TRHZ		        GENMASK(31, 24)
+#define		TIMINGS1_TWB		        GENMASK(23, 16)
+#define		TIMINGS1_TCWAW		        GENMASK(15, 8)
+#define		TIMINGS1_TVDLY		        GENMASK(7, 0)
+
+#define	TIMINGS2				0x1028
+#define		TIMINGS2_TFEAT			GENMASK(25, 16)
+#define		TIMINGS2_CS_HOLD_TIME		GENMASK(13, 8)
+#define		TIMINGS2_CS_SETUP_TIME		GENMASK(5, 0)
+
+/* Configuration of the resynchronization of slave DLL of PHY */
+#define DLL_PHY_CTRL					0x1034
+#define		DLL_PHY_CTRL_DLL_LOCK_DONE		BIT(26)
+#define		DLL_PHY_CTRL_DFI_CTRLUPD_REQ		BIT(25)
+#define		DLL_PHY_CTRL_DLL_RST_N			BIT(24)
+#define		DLL_PHY_CTRL_EXTENDED_WR_MODE		BIT(17)
+#define		DLL_PHY_CTRL_EXTENDED_RD_MODE		BIT(16)
+#define		DLL_PHY_CTRL_RS_HIGH_WAIT_CNT		GENMASK(11, 8)
+#define		DLL_PHY_CTRL_RS_IDLE_CNT		GENMASK(7, 0)
+
+/* register controlling DQ related timing  */
+#define PHY_DQ_TIMING			0x2000
+/* register controlling DSQ related timing  */
+#define PHY_DQS_TIMING			0x2004
+
+/* register controlling the gate and loopback control related timing. */
+#define PHY_GATE_LPBK_CTRL			0x2008
+#define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
+
+/* register holds the control for the master DLL logic */
+#define PHY_DLL_MASTER_CTRL			0x200C
+#define		PHY_DLL_MASTER_CTRL_BYPASS_MODE	BIT(23)
+
+/* register holds the control for the slave DLL logic */
+#define PHY_DLL_SLAVE_CTRL		        0x2010
+
+/*   This register handles the global control settings for the PHY */
+#define PHY_CTRL				0x2080
+#define		PHY_CTRL_SDR_DQS		BIT(14)
+#define		PHY_CTRL_PHONY_DQS	        GENMASK(9, 4)
+
+/* This register handles the global control settings
+ * for the termination selects for reads
+ */
+#define PHY_TSEL			        0x2084
+/***************************************************/
+
+/* generic command layout*/
+#define GCMD_LAY_CS			GENMASK_ULL(11, 8)
+/* commands complaint with Jedec spec*/
+#define GCMD_LAY_JEDEC			BIT_ULL(7)
+/* This bit informs the minicotroller if it has to wait for tWB
+ * after sending the last CMD/ADDR/DATA in the sequence.
+ */
+#define GCMD_LAY_TWB			BIT_ULL(6)
+/*  type of instruction  */
+#define GCMD_LAY_INSTR			GENMASK_ULL(5, 0)
+
+/* type of instruction - CMD sequence */
+#define		GCMD_LAY_INSTR_CMD	0
+/* type of instruction - ADDR sequence */
+#define		GCMD_LAY_INSTR_ADDR	1
+/*  type of instruction - data transfer */
+#define		GCMD_LAY_INSTR_DATA	2
+/*  type of instruction - read parameter page (0xEF) */
+#define		GCMD_LAY_INSTR_RDPP	28
+/* type of instruction - read memory ID (0x90) */
+#define		GCMD_LAY_INSTR_RDID	27
+/* type of instruction - reset command (0xFF) */
+#define		GCMD_LAY_INSTR_RDST	7
+/* type of instruction - change read column command */
+#define		GCMD_LAY_INSTR_CHRC	12
+
+/* input part of generic command type of input is command  */
+#define GCMD_LAY_INPUT_CMD		GENMASK_ULL(23, 16)
+
+/* generic command address sequence - address fields  */
+#define GCMD_LAY_INPUT_ADDR		GENMASK_ULL(63, 16)
+/* generic command address sequence - address size  */
+#define GCMD_LAY_INPUT_ADDR_SIZE	GENMASK_ULL(13, 11)
+
+/* generic command data sequence - transfer direction */
+#define GCMD_DIR			BIT_ULL(11)
+/* generic command data sequence - transfer direction - read  */
+#define		GCMD_DIR_READ		0
+/* generic command data sequence - transfer direction - write  */
+#define		GCMD_DIR_WRITE		1
+
+/* generic command data sequence - ecc enabled */
+#define GCMD_ECC_EN			BIT_ULL(12)
+/* generic command data sequence - scrambler enabled */
+#define GCMD_SCR_EN			BIT_ULL(13)
+/* generic command data sequence - erase page detection enabled */
+#define GCMD_ERPG_EN			BIT_ULL(14)
+/* generic command data sequence - sector size */
+#define GCMD_SECT_SIZE			GENMASK_ULL(31, 16)
+/* generic command data sequence - sector count  */
+#define GCMD_SECT_CNT			GENMASK_ULL(39, 32)
+/* generic command data sequence - last sector size */
+#define GCMD_LAST_SIZE			GENMASK_ULL(55, 40)
+/* generic command data sequence - correction capability */
+#define GCMD_CORR_CAP			GENMASK_ULL(58, 56)
+
+/***************************************************/
+/*  CDMA descriptor fields */
+/***************************************************/
+
+/** command DMA descriptor type - erase command */
+#define CDMA_CT_ERASE		0x1000
+/** command DMA descriptor type - reset command */
+#define CDMA_CT_RST		0x1100
+/** command DMA descriptor type - copy back command */
+#define CDMA_CT_CPYB		0x1200
+/** command DMA descriptor type - write page command */
+#define CDMA_CT_WR		0x2100
+/** command DMA descriptor type - read page command */
+#define CDMA_CT_RD		0x2200
+/** command DMA descriptor type - nop command */
+#define CDMA_CT_NOP		0xFFFF
+
+/** flash pointer memory - shift */
+#define CDMA_CFPTR_MEM_SHIFT	24
+/** flash pointer memory  */
+#define CDMA_CFPTR_MEM		GENMASK(26, 24)
+
+/** command DMA descriptor flags - issue interrupt after
+ * the completion of descriptor processing
+ */
+#define CDMA_CF_INT		BIT(8)
+/** command DMA descriptor flags - the next descriptor
+ * address field is valid and descriptor processing should continue
+ */
+#define CDMA_CF_CONT		BIT(9)
+/* command DMA descriptor flags - selects DMA master */
+#define CDMA_CF_DMA_MASTER	BIT(10)
+
+/* command descriptor status  - operation complete */
+#define CDMA_CS_COMP		BIT(15)
+/* command descriptor status  - operation fail */
+#define CDMA_CS_FAIL		BIT(14)
+/* command descriptor status  - page erased */
+#define CDMA_CS_ERP		BIT(11)
+/* command descriptor status  - timeout occurred */
+#define CDMA_CS_TOUT		BIT(10)
+/* command descriptor status - maximum amount of correction
+ * applied to one ECC sector
+ */
+#define CDMA_CS_MAXERR		GENMASK(9, 2)
+/* command descriptor status - uncorrectable ECC error */
+#define CDMA_CS_UNCE		BIT(1)
+/* command descriptor status - descriptor error */
+#define CDMA_CS_ERR		BIT(0)
+
+/***************************************************/
+
+/***************************************************/
+/*  internal used status*/
+/***************************************************/
+/* status of operation - OK */
+#define STAT_OK			0
+/* status of operation - FAIL */
+#define STAT_FAIL		2
+/* status of operation - uncorrectable ECC error */
+#define STAT_ECC_UNCORR		3
+/* status of operation - page erased */
+#define STAT_ERASED		5
+/* status of operation - correctable ECC error */
+#define STAT_ECC_CORR		6
+/* status of operation - unsuspected state*/
+#define STAT_UNKNOWN		7
+/* status of operation - operation is not completed yet */
+#define STAT_BUSY		0xFF
+/***************************************************/
+
+#define BCH_MAX_NUM_CORR_CAPS	        8
+#define BCH_MAX_NUM_SECTOR_SIZES	2
+
+/* Command DMA descriptor */
+struct cadence_nand_cdma_desc {
+	/* next descriptor address */
+	u64 next_pointer;
+
+	/* glash address is a 32-bit address comprising of BANK and ROW ADDR. */
+	u32 flash_pointer;
+	u32 rsvd0;
+
+	/* operation the controller needs to perform */
+	u16 command_type;
+	u16 rsvd1;
+	/* flags for operation of this command */
+	u16 command_flags;
+	u16 rsvd2;
+
+	/* system/host memory address required for data DMA commands. */
+	u64 memory_pointer;
+
+	/* status of operation */
+	u32 status;
+	u32 rsvd3;
+
+	/* address pointer to sync buffer location */
+	u64 sync_flag_pointer;
+
+	/* Controls the buffer sync mechanism. */
+	u32 sync_arguments;
+	u32 rsvd4;
+
+	/* Control data pointer */
+	u64 ctrl_data_ptr;
+};
+
+/* interrupt status */
+struct cadence_nand_irq_status {
+	/* Thread operation complete status */
+	u32 trd_status;
+	/* Thread operation error */
+	u32 trd_error;
+	/* Controller status  */
+	u32 status;
+};
+
+/* Cadnence NAND flash controller capabilities */
+struct cdns_nand_caps {
+	/* maximum number of banks supported by hardware. */
+	u8 max_banks;
+	/* slave and Master DMA data width in bytes (4 or 8) */
+	u8 data_dma_width;
+	/* is Control Data feature supported */
+	u8 data_control_supp;
+	/* is aging feature in the DLL PHY supported */
+	u8 phy_dll_aging;
+	/* is per bit deskew for read and write path in the PHY supported */
+	u8 phy_per_bit_deskew;
+	/* can slave DMA interface is connected to DMA engine */
+	u8 has_dma;
+};
+
+struct cdns_nand_info {
+	struct device *dev;
+	struct nand_controller controller;
+	struct cadence_nand_cdma_desc *cdma_desc;
+	/* IP capability */
+	struct cdns_nand_caps caps;
+	dma_addr_t dma_cdma_desc;
+	u8 *buf;
+
+	struct nand_chip chip;
+	/* register Interface */
+	void __iomem *reg;
+
+	struct {
+		void __iomem *virt;
+		dma_addr_t dma;
+	} io;
+
+	int irq;
+	/* interrupts that have happened */
+	struct cadence_nand_irq_status irq_status;
+	/* interrupts we are waiting for */
+	struct cadence_nand_irq_status irq_mask;
+	struct completion complete;
+	/* protect irq_mask and irq_status */
+	spinlock_t irq_lock;
+
+	int ecc_strengths[BCH_MAX_NUM_CORR_CAPS];
+	struct nand_ecc_step_info ecc_stepinfos[BCH_MAX_NUM_SECTOR_SIZES];
+	struct nand_ecc_caps ecc_caps;
+
+	/* part of oob area of NANF flash memory page.
+	 * This part is available for user to read or write.
+	 */
+	u32 avail_oob_size;
+	/* oob area size of NANF flash memory page */
+	u32 oob_size;
+	/* main area size of NANF flash memory page */
+	u32 main_size;
+
+	/* sector size few sectors are located on main area of NF memory page */
+	u32 sector_size;
+	u32 sector_count;
+	u32 curr_trans_type;
+
+	struct dma_chan *dmac;
+
+	/* offset of BBM*/
+	u8 bbm_offs;
+	/* number of bytes reserved for BBM */
+	u8 bbm_len;
+
+	u32 nf_clk_rate;
+	/* Estimated Board delay. The value includes the total
+	 * round trip delay for the signals and is used for deciding on values
+	 * associated with data read capture.
+	 */
+	u32 board_delay;
+	/* Delay value of one NAND2 gate from which the delay element is build*/
+	u32 nand2_delay;
+	/* skew value of the output signals of the NAND Flash interface */
+	u32 if_skew;
+};
+
+int cadence_nand_init(struct cdns_nand_info *cdns_nand);
+void cadence_nand_remove(struct cdns_nand_info *cdns_nand);
+
+#endif
+
-- 
2.15.0

