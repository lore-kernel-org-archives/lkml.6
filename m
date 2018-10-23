Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FBC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD4520672
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CkixHAjQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IZQsH/e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD4520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJWI0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:26:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbeJWI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:26:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9N02a34009139
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=facebook;
 bh=HJrfFuZl7ABykfv0gfykFXlxIy7eAAoBVIHD9mhgQrQ=;
 b=CkixHAjQ4dt5FQitEBxvKZeDbwug9+Rn6hhit8l18PoRNM/QCDeh1249vp829T+pLQNL
 tS1HmRFp0A5JrFVUbMWG5heJFIWujfCKKz+eI+9nn8ToFckw1780vakkmw5GUQWWoPXm
 4Inr13U6WSQYCUpVsAfgFTgp6ZQVhGs70WM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n9r8h03bv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:05:16 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 17:05:16 -0700
Received: from PRN-CHUB06.TheFacebook.com (2620:10d:c081:35::15) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 17:05:16 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 17:05:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJrfFuZl7ABykfv0gfykFXlxIy7eAAoBVIHD9mhgQrQ=;
 b=IZQsH/e40t+Cy2c1Vnrz1N+RW3rla26x+M530vjhX/YBO0NuBGU4J3ECoGBpb/zhflvxDvOsXqWck405Zk1WKFOLT0vEQsKsNFrK6ful9EuFUHe2KJlCn6NNttYM76vUCz94q2F1BHB6Sbmqnbnk6oYjxyy+gV1BhMJGUzM2WEE=
Received: from [192.168.1.213] (67.253.148.112) by
 BN6PR15MB1876.namprd15.prod.outlook.com (2603:10b6:405:4f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 23 Oct 2018 00:05:13 +0000
From:   Chris Mason <clm@fb.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Date:   Mon, 22 Oct 2018 20:04:58 -0400
X-Mailer: MailMate (1.10r5443)
Message-ID: <2720F796-F3D4-4BDE-B29C-EF2A045F28A3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [67.253.148.112]
X-ClientProxiedBy: LO2P265CA0424.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::28) To BN6PR15MB1876.namprd15.prod.outlook.com
 (2603:10b6:405:4f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a98a2e3-c324-4492-c18f-08d6387b352e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1876;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;3:GV8+T1U9Sc0E4oKV+uUhqCH7T++A2WsZvSAixXnlvsI/QwapqaM76knB7lNg1VuJxb0SUXccRPoSikPXaSC1cSKD+k1ykgAy87zlw9smsva9kBT07lb/JariLxayym/bUvX71+9eTu1Yi9xCx31ho1nL+dfZ6vVblPI+4y0hPwThu27vuR2nKCO7sBy0IagjiM24a93UEOGBMn0exF6W9g3//EPvYVgRNy5TXhjxojifSdbgerECKB4AICe+P+yN;25:0QhacpmHAU/XDHU0izbYLcc6X1ZiUQ6VLsf6aTVWSO0h/3fO9IB0f5cUd+EEvXIf1l3tda+PwtuRG9w+awocRQPZZQYQljzhwLt4K44VbaAtIW4Y4DbZ9b/vNAxmii+agDaaH0MG9/lQCtEEyH4YMnEWf9lIVON2bAMEODyKA/y3JEFuCKBRhE/b/nVl4RuwgoU4O6lxl+kcTLV6tIqDyPgHqPOs0szoiYWqJeHOzkXPM+OTyFzTwrlTv+teAeCOFoLxs3N4E87ER8ttgMsd9ZowLmbxpz3L1dvL4yHDT8rigAnaHhkiBFZMxulHFW+QlDPlsGHpPoPB2GDssZJlbw==;31:IA6Nas2xyoOpluThDFEXn2XuXTkLm82qhbIokhrHuovRldMK/5+/r29F+iI6FSLEiEXicvsz+ya5y84HamW6sbzU2vty84YVrkBoDRTHJFT1NJ8lKvn8qY6pLdRcjeIimY20epNeUh2Zw8sDbQJ3XYsPvqF1Lzc9Se7ydaa1mnUYFMgRNwsbDxJONo1/hQiuWAnBa9amnJh4x5pJupsYIej+hcHbWQ2EjC82W1G/OSk=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1876:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:KYlZrgLSuqbjhqX0mZOSJHc9zX7tAC215IfSoMW/5augCwOXLAZJDvvbIL2ykYaq3kDapnbkYMyYLeoh94dRqA75IYbZowah2nJnr3Sk6+t+GVXM7QSF+eTlg98culVrqtfvWL+2O13Lf53nXYAxku39hDArnaupOMDir1IDiEWgOOFIzdKui3g06CKfkraznwwD/Jfov8vnb7Xx+vynXr7lG6f8f1KVn6cOxN40IN3FUBYBF4bYLI4X1z29u3kJq6X0t6FwKR48TW8tP2gkF6uzFeIs2JPj2F5bPu2ZyetarVWGEZUFz5qtEQ9FbdWAcdtoysMsSyowMA5gMhwe3olFuoqG8vqSLU5teQACytmDXpAVfHEmv3axL17EDqDEi08DsJA+P6NriGtiGop0AUBCSW0FNwQ+3C+SHhXlHzf8iYGMtZv3Vul8GqqfmFmyeTKBxPfp7nacVz0mLt5qd83jBySJGQfBelivg4nRXhYkuKq54TBz7twgOiWdqNDD;4:NW9GlT2tYNjukCLoZ48Bb2lX0JjSWVcBLbSfnsFgT3wciKijqYlxVSOUuiTOsOKNGBO0GA0xkfW1HiV1tC7khVfGWAHzXVLo3pxFLOMT7nyKODw9+kTASLebRXEjJ9at3WxCPil7e2bSW7bHyr6xk7rwJOWcu+9xR/as7xulPcuaUa4S7e4fq8BFsm7KKxAIU1C/ikpMonS8XDRgh9G73I2Dd0jnnvmMpMKtDd+6/m2hEAtNx2bExJ7gMrF7ntANL2shJHejorVFg5qejJ2G5DrgLkEF5ChSglCwkYlirJGgUHQgrj/I1vEdz5uZ5zpM
X-Microsoft-Antispam-PRVS: <BN6PR15MB187680905B08D8064A6431DBD3F50@BN6PR15MB1876.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR15MB1876;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1876;
X-Forefront-PRVS: 0834BAF534
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39860400002)(366004)(346002)(136003)(376002)(53754006)(189003)(199004)(6916009)(386003)(117156002)(6116002)(6666004)(66066001)(83716004)(2906002)(305945005)(53936002)(486006)(86362001)(7736002)(16576012)(16586007)(26005)(52116002)(50466002)(77096007)(16526019)(186003)(97736004)(3846002)(476003)(956004)(2616005)(50226002)(106356001)(966005)(25786009)(36756003)(316002)(478600001)(51416003)(82746002)(81156014)(8676002)(6306002)(105586002)(33656002)(8936002)(68736007)(81166006)(67846002)(11609785009)(47776003)(6486002)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1876;H:[192.168.1.213];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1876;23:j2bOdHSI3RNlM+B+Od/4rUZZMsFFjqrgy6quyg4On?=
 =?us-ascii?Q?Slb6oc+HVvpvD2ZA6ZH9R5+O1KzjgJzB3MP0h6ydfxtDqBVl9rPmLp7WNXAi?=
 =?us-ascii?Q?m5iBBRCW78MZtD8zXi/P+d8zU3q/tPm1hntvIorQgFgBhV2mjzkhzUP9PjRW?=
 =?us-ascii?Q?z4rKBb5dDkDvglZk+K5/3/YazSFQM4Qv7GeSgNE6BK5Z4u8UD3ez+11Jsoga?=
 =?us-ascii?Q?pLQV8CDUg0LTs8pJ/bmwUdtOV7IhJS55qNryv+12VCg6CFM7+oCm8s/8XLX/?=
 =?us-ascii?Q?P/pBXQ8J5MSPKCt30Upqu33KqL3btPmKxPDePfiiD6vXDPHK2Gz6pBi+gYsW?=
 =?us-ascii?Q?5jP5iRD3bXzmY09nfbhUhv+UAmqWFZyVj2VFOzDLEZhkg5OtKFF0LzZ3P2aG?=
 =?us-ascii?Q?MNUEGCLxTgM64LhLVNhgd1XlDTGWA6AMhZfCaqAZXcfxtlKAEF3xdaS7hhsT?=
 =?us-ascii?Q?CQoFRe0cLNx7GspKi58kDVJMl9pmVUp5JwlxHXk37TKRnj3Sc2Wnn4Tv93Jk?=
 =?us-ascii?Q?32RNPJk+dxRdnqi8zfSagIVNeTDX8f6vJB1SHIeYBba2Ef6tPYFAXnC2ildN?=
 =?us-ascii?Q?KpD8LYuF9OqBaa6F82faKCZpYDhllReYgrfdxNg19iOM7yKqZWoaB4fCbj7v?=
 =?us-ascii?Q?9LdKtDeYbqKKWyWKgiv/y4LcvpRmwJe4/4TUdIukd9mZ9yFkSOoCZruVxttI?=
 =?us-ascii?Q?5nU25STf3PnzjiGMroQrBKLofK0PnlpUKWC+S44Mj4BgLh3T95koVV9t+Gw+?=
 =?us-ascii?Q?Iw0BZipRtDEIk7Te2Ms1maSWyjMYmypD0HUS8VQGY4/e+y6kHZHWPnhdRoYT?=
 =?us-ascii?Q?Vvk6pEjVkkK1QpbeZAVOmv68sGlPxxzhMfc4v/MTrkp8UDDTKzTOYhxiR45b?=
 =?us-ascii?Q?NoohsBj+WXfDWpDW6wLS9J6vu2bIF/kgtkkSgwB/PIKawKbsz7ODaG4iZwUQ?=
 =?us-ascii?Q?HNgH0yQuL6wEPOUcJwq1bkf5GDkKFqZHwj7epWboRGHjtd4CtGFm2RMEFZri?=
 =?us-ascii?Q?ysOX76e6wY/LNFhaALks+BnuB5o2HZ/095/jQ20yBufUquOOoCkDjhVe5fUu?=
 =?us-ascii?Q?Egt6sxAXd84o2yJjI62ukbjY2umM2p0GumeByhM9PnOq9zrKNOc882EYDWDN?=
 =?us-ascii?Q?MrZNoQz3yuKvGtfDThDIDM/rs6eXmzrY2ESAMnawJXtPWfvyvLxxaNEjzkDC?=
 =?us-ascii?Q?ui4CbKXCAVd7SHEFUtjGQ0iXEXRnfkqdsxZKQO6tuZClSduJGzK9P36u7c90?=
 =?us-ascii?Q?kOjJU70h2nuk1wY3eYnTneJ6GmOOK9rQrLiZ+kQEUtuACsUpc4Q2SZxVJbvS?=
 =?us-ascii?Q?PKQerJrHQhhur4TtuzIqbg=3D?=
X-Microsoft-Antispam-Message-Info: VFFn2ZbNy83lznVrDxEarNI2doAo+i9RemcBwEHflnHNrB97FYWOOWQkMPiJxhyVaLaSm4S3AE8uE9S+gA/v9KFurUYeIoCIkoacKIQ59aVtuYTnYVoZleaTY5ulvaeOhAvc1iGLkofYlm+v39m6YwlzAEv6/4hmuqpl6lG7mDG3KtOmKlWBs7PZtjUyxophZnZ7bt1HIEfRRjYhGjd5EtFrxVn7YCdMWppGoK5HpOj7w6oI4U75IYX1YG+lLV301maaNNn7dppb6CjrkGA/IyA+bnWeWUQ5cvGULR90CQzfuNrJGRKytdjMV+N5AfBnI0qDCNeQnE0COMeowvWNNNW8wail0apYDFVzjkeUECI=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;6:xEQVdgnLX7uVvRBEDiTyC/JnXKtifpO2KBu92+GQAKZRs3ffMTAA0gV6KSECBAMKHUDRNjEbTxrO2Yrsxr5zFrqc7gFCuP7QPDV9L2AaUJhseU7zCqo7oj3dUTBR8QgvVx+C9u21iQzkgRmhMIpW/1t8NZBSxm+9u2DNoofljVgAzOyTD649koxgEJ59Jwpq/zVx6QJSG4hfC+WXUdMuPxFwxdmmnPXvgCVnON5KiGqsQNpnMzAuGPaMfjp25tDKVENZYJzdBf5huD3xZ69fVk8gWUkFsu3FZ3KiPdr2m1CeR6nF1SK402i8vYzT6y7zxr2lO17CkxYV048IZzxuOotzqaz8F7e/8mDTc7oTYqAa7AmAvQ91L7aZ7xOeBChovHrxEhnHjHvEo9FEWq2SZmic3GSJuhzXtCftAifpPHsGcc3qned27ZLg2s9pWDn92VKoqjkbxhXg3xQh439gCA==;5:2bExctutyG/ivzGqggYsAuxIZepX31GUwv1TQI40dUlSEPs8DPZUQDeQk3VbGkgaRqvmXlxOZb/LysLtB/PQHlPKguflv+KTbQKLqKds8Om4kysPtJCS3olbVtj/xd5MgfLDu35yHrNr6p76cHXz7jKOsB1F/dMLG6ihIXOPPKw=;7:pvhdb695MUSQczjUr78LLF7N8J8KMM+VDA1oiTy9bdJqw9yFcnLVV8nTQ1pm228f7QLNJ0423NYK9HxWSXfng72JkQjEkF+IQXGuDQK7ZolYW3iO4+4RQjlrD1He+trw1BHrrlKEDmBGAj6FBl69g2AWcpVJwlnANSTp9JmD874/ZA4agehDPwPumKfU9rX885SF1x1NEQqEu12UJ+17T7+BvEvZ9cbt/3jT4f79+pkUq4Dr+UvoQxFm7WMqkNmK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:GbJOfkoWk4ABZO4AOhyNd3eSxxY0iRLezkUDrpKtZ4sazSStMyQNkuF1hvEGkJX/KJsim0neqI/3h9/mO56Gm19VXHe2GiiZL+1oB1do1MSOfXbNAKDF0MGQPzcy2i2B6pKCidFlff6SwUCA4kAmsQCl/6Wpm6empeWRst5FTKg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2018 00:05:13.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a98a2e3-c324-4492-c18f-08d6387b352e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1876
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

The Linux Foundation Technical Advisory Board (TAB) serves as the 
interface between the kernel development community and the Linux 
Foundation. The TAB advises the Foundation on kernel-related matters, 
helps member companies learn to work with the community, and works to 
resolve community-related problems before they get out of hand.  We're 
also working with kernel maintainers to help refine the new code of 
conduct, and serving as the initial point of contact for code of conduct 
issues.

The board has ten members, one of whom sits on the Linux Foundation 
board of directors.

The election to select five TAB members will be held at the 2018 Kernel 
Summit in Vancouver, Canada.  The elections will take place at the 
conference center on Tuesday November 13th, at 5:30pm.

The election will be open to all attendees of all of the Linux 
Foundation events taking place that week in Vancouver.  Anyone is 
eligible to stand for election, simply send your nomination to:

tech-board-discuss at lists.linux-foundation.org

The deadline for receiving nominations is up until the beginning of the 
event where the election is held.

In past years, everyone running for the TAB has given a short speech 
before the voting began.  We've received feedback that the speeches add 
logistical complexity for the election, and may not be the best 
indicator of how well qualified someone is for the TAB.

Instead of speeches, this year we're asking candidates to include 
statements about why they would like to participate in the TAB.  These 
will be combined into a slideshow running during the election, and 
available via a public google doc at this location:

https://goo.gl/rPEc2v

Even though the deadline for nominations is right before voting begins, 
any statements must be received by Monday November 12th at 5PM Pacific, 
so that we have time to setup the slideshow.

Current TAB members, and their election year:

Chris Mason 2016
H. Peter Anvin 2016
Olof Johansson 2016
Rik van Riel	2016
Dan Williams 2016

Jon Corbet 2017
Greg Kroah-Hartman 2017
Steven Rostedt 2017
Ted Tso	2017
Tim Bird	2017

The five slots from 2016 are all up for election.  As always, please let 
us know if you have questions, and please do consider running.

Chris Mason, TAB Chair

[1] TAB members sit for a term of two years, and half of the board is up
for election every year. Five of the seats are up for election now.
The other five are halfway through their term and will be up for
election next year.
