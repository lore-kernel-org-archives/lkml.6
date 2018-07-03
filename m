Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0074E21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DLciV1As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0074E21F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGCT7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:59:49 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:23298
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753131AbeGCT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hig5zP/Crja7W2gdA1t1JA1o/Fohtd3bFBIV//M7m7s=;
 b=DLciV1As/YaybWs1haFnzxsZLUwLB4l2NAEeVjgvX9+ZUDSX0FgPu6d/DjgGsQonV8KUGVDdGatq60EDUhtWfNyvyyDSO/xBJ/HGdcEH88k0YCE5sWXCBPoqbMqQEtNU77Z17aIqU7jbGVyrc1FBcWumFRzVGGl9DGqNrrSqjvw=
Received: from BY2PR07CA0087.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::40) by DM6PR07MB4716.namprd07.prod.outlook.com
 (2603:10b6:5:a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Tue, 3 Jul
 2018 19:58:30 +0000
Received: from DM3NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by BY2PR07CA0087.outlook.office365.com
 (2a01:111:e400:7bff::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:30 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT016.mail.protection.outlook.com (10.152.98.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs8006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:28 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwOAr012325;
        Tue, 3 Jul 2018 20:58:24 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwOHK012323;
        Tue, 3 Jul 2018 20:58:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 10/15] Introduce Cadence USBSSP DRD Driver - added trace files.
Date:   Tue, 3 Jul 2018 20:57:54 +0100
Message-ID: <1530647879-10007-11-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(36092001)(26005)(14444005)(186003)(51416003)(6666003)(4720700003)(5660300001)(26826003)(8676002)(68736007)(87636003)(478600001)(11346002)(446003)(336012)(426003)(69596002)(76176011)(50226002)(305945005)(48376002)(50466002)(356003)(47776003)(126002)(2906002)(106466001)(86362001)(8936002)(2616005)(81156014)(81166006)(476003)(316002)(107886003)(97736004)(54906003)(110136005)(36756003)(53936002)(105596002)(16586007)(486006)(4326008)(42186006)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT016;1:IUNYL4MHX7vQeZMYfTxxHD/kiQh8E69pH4tjzHYxESwq1WUiBRA0jL1ifQUJTX1E0qCwOQOLR0Phiv4kfD/IeKJTeOCqU1kAX2wwP/cfasQ8Wo0JV6T175EneV6RjCJf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0bfd79-69cc-4d9b-dcee-08d5e11f593a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:oCyw89TNemR9nJIAwwzWv10R9EzgMuRv6AuzdKjAOHmG5G7IC8O6oUXxCzimypo6eK4QANBeMYfhu4JpNTCU5erQ09Gp31G9TNokZca6GO2zMEe4JmIZY55xj4LQ939AlZuTtHIk69p1BV3M6JRkbRP1/Ij6/q7/Q8YAWAr6Mjb2mm/lbeLWvT9eliFg35ry1DvFHbsZN/rAo1udqRIJgXdsxV2OL+yYmHSN55EeGzcbpikjcV5rYftJBYuC/ONqD3eJpwgW/3M7jf7wMyXlkzdNgAVCt9olLB9ZhF3b3w9u8V+omVvW2DuN3XmvY7vzFMh/eG+fN2m9PS0XsUyhlQ==;25:gKvkmu8S36c/ZEPR+p3fizz4+kpYZZHUxK/SvM4ZBbob2hnaCy+wrxCD1nDKferi+121K2v1VN03GvgNNKxInzY+dJlDCc4bSonS0f87d8pc5AUUp2OSfrIy7YdbBJJnV/XDmiseSVC1fwYatGVcACZ4gldVdQzCat516oZn1L+3DALKPHjMHC5xujmqe0EbnkzEjPkx6kY1o9ANhO8cTUbyfe8uVA2kUNImfpZq4F79Ch7ZtjVOn2RA+Da4NppjpQCsJHJL/ONdQn4Uxww+KS+vrGt2uaT4t1tWJ8t10CL1vKcn68UBesodHAkDCG5lavbjs+qxJ4jz2NC/UEiIqQ==;31:Yb9jrQZPLQJZGWLz3jedX275Tpj8bCqBTrLmmW/tmTNR60iFAikQM00PmYGoIglznsGvXnjo2sb8473JFXl92k7hYLrOzXZHcxMZtIU4ngEG6n8iAhJnmIoBK5v1Caqpzj2HpFFy5iKEYK6/MFLBYc1Fqk6paNk/sG/wD1n9DVL320GsWFIZ4+sHUh5CZogqTmKPkJSKjAySDD6IbFahP3UpATRiPadw34cuHXRAv+I=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;20:9l626A4mgphOoBtsOLt4sYU1Qt6hqZC6k0ba4U5YwSeKV8BIZfS+dxHnnrRzHA5xeWHmIwXFvYAdgWudzYVEpIuIGuyNWI/61TTqPQgqf98plsfinWQKA04nKL+TOKvJbazW9HcVefkT4oqRsQs3RtXE4et+isL6+zBeKJba+5+udTLDgTuuZMF5RYR6mAOurEuNVX2UoOSAg0oJZRz7tkQhCFVNd4rI/w4m4eINxcatlfpEDpl0gg+weABvi89KKRWQvUtL57qEcuWOvujznMjIMOP+idtaP75EZe6Kol+tlUp1+NAyI+bAL5bJynSQh7XjfTlDOADNyWZF4pS6CJzlzGpB5ikhr/LzlY37M4MhX/HJKhzSnMeiB4XZ7AfFKIKFxV27Pl/SJ0mZHnSRFN+gDtIMyPxGaNDb+yMjE5x4VDinmErSNnac3CsFh5VRJ66ugTEBWh7iDO8A8EOTFGWBnHtFl3Th3fr5VUJOuuXzC0FhIA8SrI+Cw0Ubqg67;4:7b8o+0FAAVxYI3WZR2oB+Z9wjGvImdg/0/b9mcTocapvHyoncNCrd7X9V3nuc1dkfMNmhI3tHFTa8/Q4Djlf0k4p1t5YDiadpVwY3EXWBn3TduuzflZFGQzJzhORJWwwjZa36pq4SDzbbqZf7JJcyy8XV3OiBfRJo8NTBsybL/Bk3LQi9L8TKgUenWSNJT52QuB6Nxz/paSXzXKBvAqZtZbfrkohGDuCcoNh6XzCK/GhvXayudrzui5hoJOjJuB86Dk+fPwur021cs86u3ELHSeDPu+Ow/K7Q+LynCCmjh1NcoeT9U8cfpKW8jGewRpu
X-Microsoft-Antispam-PRVS: <DM6PR07MB4716CF2BFA1A4A9FC51D34F2DD420@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:mb+0/FppoJO+XVARXVSXWPTC7+W9nzEJNJKoMPRO+?=
 =?us-ascii?Q?JNDNoiMeZ/cHEPcLExXlUCgOuQqVOIMXA5tj5P3z6WQc5pvx6d6rRNVmVRly?=
 =?us-ascii?Q?G7ILIk0wgJv5zdpAmVpoY4qm/d9ytQXXlgRuL8HOkdl+drYL5AIhqTGKPBne?=
 =?us-ascii?Q?Q2LPtKU7Cahb2CzCTIuCanmv8rPXDm+0I9ZoWrOk9xHYqkzIQJh8MPlShfTx?=
 =?us-ascii?Q?PmZej587YiFGqJnmbAOSFPWfH5iwKEgKuZJmrhpqO9dHD+QE9yK3vL7UK+Lu?=
 =?us-ascii?Q?I+0152YQNI9UDwhyoYu/eHWvIgJTJiKjYWYD8C1MCqvtkPPpk7fhxdQFQZUn?=
 =?us-ascii?Q?E+c4rBTpgSTbBtDeEVHYCruLTJ3CE0cAH5VpCewYrl6KFfkukLDPCm+BY5pn?=
 =?us-ascii?Q?qlQxXpqVtGbYT3eE1qGo+2+AK3VHHBtihegbtucprbwSzL658ugb9kchDjph?=
 =?us-ascii?Q?LQnCMutfPrLn/B5gZhadxti6PSCrEblhcw+SIYB9LRb85f7VrXa4HisA5LEc?=
 =?us-ascii?Q?IpZlEZbKuACBtth+gg/kvmD8Z7vwwuvKyaj0Wi+rSXy3Drz5hSK0Ge0opJQ4?=
 =?us-ascii?Q?3yY50vWbOBn/b45CEDjk9ygeWLSVoeQtdoGre+ANJ9KGNIWk2u9uiU066fmZ?=
 =?us-ascii?Q?b3JNziOdJtdrGujfyX4B0si5VMnAyGFwRBSYmSqmqwvrCXtKCbbqcwliYIuy?=
 =?us-ascii?Q?cOGDRYq9cdujAT3Pv6ojvDrA+Pasptt1jRTqQcEsxp7SqfDZbIy/v/TzOE1x?=
 =?us-ascii?Q?75mx/CJ+N59IjGAi5GoDmfb+EeVxgsELO77p8blIsjFBYs9xWmwVIRGd/0pQ?=
 =?us-ascii?Q?fiFIenKLe7tzqmtIUcwBYxnyeDjT3Dca8SSWkAZh7Uq/jVJrE/9vyFOXarOP?=
 =?us-ascii?Q?xYYW759iAiJQdKuDaJBzeOhiGmuFIA/HK7YiSK+i1H5ccY5l2JtOLU6yjgc9?=
 =?us-ascii?Q?oPYjFv+Q2gwvr1XTCq2KGmYLRwF16bOcVmsX3s4PJFcexEpjLO9rDDxBW6R6?=
 =?us-ascii?Q?8unoyBEu3QaK6ZsqGaKMFijWbYO8ufVPbums6YNb9+BRrYfKCyz0x2qsLXdh?=
 =?us-ascii?Q?zJ//09tv15dtarKkJCpr/LgQA1cAmov4Scr2YMUHYPS+s05hXPFN+UANZPkd?=
 =?us-ascii?Q?4JlvIsvkINEB7ZbSAV9dimY67KQSYznhyWh2NfqhhSa+j7uJNUEgQx4QeqfE?=
 =?us-ascii?Q?qkq3F/UzrXr0I7rsR1nL6w8dK5Ul33fmCiQ1Zscvb8Ga/45ssXkI0icfg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: uluK3AdP09dPGmOVt3pH2UztKEUuuO0xWW1d6zYHcLLMwYoAUV4/V8kTGCVkhOJkTFkbKC6jkDGiv/2eVuxIJb1wCpMhUfOu5MqLE00K9IGCFAouAL1XmfzMlEJ1Lhi+6xEuL1rWZHh2y4ceU5BkS9B0tF7GYLNK3HKuyOSj6PijH+9+eivEdHHoP0Rg+Qx25mAJ5To5aF9njL5vT8J4wo6yrQ4rvl6bshMamTdjqSGnowYOEaH1B827Vy8nylkYbWlWLKPUa1pEsanBa5ag+PtQWE7muGOArrUTCvppsa5usPIX82//IDKqV/MMw+5OU+v/eqVX2wlraR8O/wSYVyg4oK6FnBJH9/rRR68tJZTfQsZ+1JcOOxYMuk3tput699E2wITALLYm9wr8s1JOdg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:/VwK39BHlGnkjZVCDENH6QUqZpWBEx+xiD0Fuu5b3YKfQ9pgvR+B/mqqhSUgcMKZvc2Tp9lnA1vora5beWHTCbOPwQYd+fylkRTOL2PIakM7CMGNsx+JJKfNHS8Jq7jEqvjX1g45oMz8G6fPzgKSmk3YrIoipw/upp9PReV0X5bMfMAusFvs9ZPGIwwK8JT5ocu/jN6RMJS8vdUjjKJ4rurJzZYqRhNObSZyX/0A2og44vjwZzDXD/GH+wKLSrP07pYlyCbPcg4QlG9278LIENldnix6fSL3u9hoTse8iF8NWqKc/Hw6MRonNKfHJkI9BROhVOF/9R9ccgYol1B4bmbK/zKfh2ArYhM4YoPe6OO3dUYibq7b2PBP9EaH3/iA8cjZlMVaHSxgbj+Xp3Hm/j8GlRCvuBoNHpCJ59HBylmmsn0s1K/sd9MnMceVUXP+AgwnEKuxPIqacXHIBn489Q==;5:tddgcw7SeRIYzMoeMbiRSBYgvolbknR1p68WoNwrvzj6SlFF3hQhQpXYta4EXfhsdcVWcD2mbev6Klh/qdxg50OtKBicp8ehk0TzeHiunNFVdIgwDOKMw8BzxqIIaBxdDvbIyW8B331RSX18jgJ9hc4hrIxHsIYhF0ub+rxYQSE=;24:x87HJ/hKZohjH/qVVolvGhgGszl8V89+l9k3kehuDJX6Im1VpoMu68DlLT3AdQus9z5xHozBXLNl+/YNhv0hH21TcuylDgUeH8gdKQkj4/s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;7:6hE1ZOuYDLb8RsB9UnIKU6o4kIk6kJyrEgYyhC0YdjoPrxXOc2sgHZm8rfhcGDLAXHQFAnHWYak+rV+CwlV0N3XZKYyGV8Ne0pMDAWnaZRoLDJeP5F0KPtp4Yqb3ToM7dMaqMlx78cdDyyJWxIc/oKyJ1LRZK3/L4IIxEl660QZY8VetVzj257FYB339Vh9dnhY6bdgGaKw7fw2FM5JJvQMfFVzXI3qCPkFWjQXIja9y8epaitviliKJvvbvrfbC;20:gGx1WulTMvmFP3ms4OdQM9YUUrLTe5OVYQWBRP2arBSpfsoUEK7fBsbzOko0s8jTxrb7LNW0ZGyOYB1jhkikWYEt2dy9i1GvV16poCYmcQMzpG+b4HsXzceVwRbj0/94E4ip+66P15A8JYNlsmno7G+z7YsKJhOh0xfi0DRaGEciKxHZQTkrs1Jl1WFkcXTwqtbLtcy4XuK7rFLQ9uHdNzt5vlUtO0WEZjZC3nwwwQS+Pq9kBwTJ6QQqOASm5yHt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:29.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0bfd79-69cc-4d9b-dcee-08d5e11f593a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-trace.c |  12 +
 drivers/usb/usbssp/gadget-trace.h | 505 ++++++++++++++++++++++++++++++
 2 files changed, 517 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h

diff --git a/drivers/usb/usbssp/gadget-trace.c b/drivers/usb/usbssp/gadget-trace.c
new file mode 100644
index 000000000000..6c8ef287d81b
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Code borrowed from the Linux XHCI driver.
+ */
+
+#define CREATE_TRACE_POINTS
+#include "gadget-trace.h"
diff --git a/drivers/usb/usbssp/gadget-trace.h b/drivers/usb/usbssp/gadget-trace.h
new file mode 100644
index 000000000000..6adba591bade
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.h
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Code borrowed from the Linux XHCI driver.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM usbssp-dev
+
+/*
+ * The TRACE_SYSTEM_VAR defaults to TRACE_SYSTEM, but must be a
+ * legitimate C variable. It is not exported to user space.
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR usbssp_dev
+
+#if !defined(__USBSSP_DEV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __USBSSP_DEV_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "gadget.h"
+
+#define USBSSP_DEV_MSG_MAX	500
+
+DECLARE_EVENT_CLASS(usbssp_log_msg,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf),
+	TP_STRUCT__entry(__dynamic_array(char, msg, USBSSP_DEV_MSG_MAX)),
+	TP_fast_assign(
+		vsnprintf(__get_str(msg), USBSSP_DEV_MSG_MAX, vaf->fmt, *vaf->va);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_address,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_context_change,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_quirks,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_reset_ep,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_cancel_request,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_init,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_ring_expansion,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num),
+	TP_STRUCT__entry(
+		__field(int, ctx_64)
+		__field(unsigned int, ctx_type)
+		__field(dma_addr_t, ctx_dma)
+		__field(u8 *, ctx_va)
+		__field(unsigned int, ctx_ep_num)
+		__field(int, slot_id)
+		__dynamic_array(u32, ctx_data,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 8) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1))
+	),
+	TP_fast_assign(
+		__entry->ctx_64 = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+		__entry->ctx_type = ctx->type;
+		__entry->ctx_dma = ctx->dma;
+		__entry->ctx_va = ctx->bytes;
+		__entry->slot_id = usbssp_data->slot_id;
+		__entry->ctx_ep_num = ep_num;
+		memcpy(__get_dynamic_array(ctx_data), ctx->bytes,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 32) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1));
+	),
+	TP_printk("\nctx_64=%d, ctx_type=%u, ctx_dma=@%llx, ctx_va=@%p",
+			__entry->ctx_64, __entry->ctx_type,
+			(unsigned long long) __entry->ctx_dma, __entry->ctx_va
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ctx, usbssp_address_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num)
+);
+
+
+DECLARE_EVENT_CLASS(usbssp_log_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(u32, field0)
+		__field(u32, field1)
+		__field(u32, field2)
+		__field(u32, field3)
+	),
+	TP_fast_assign(
+		__entry->type = ring->type;
+		__entry->field0 = le32_to_cpu(trb->field[0]);
+		__entry->field1 = le32_to_cpu(trb->field[1]);
+		__entry->field2 = le32_to_cpu(trb->field[2]);
+		__entry->field3 = le32_to_cpu(trb->field[3]);
+	),
+	TP_printk("%s: %s", usbssp_ring_type_string(__entry->type),
+			usbssp_decode_trb(__entry->field0, __entry->field1,
+					__entry->field2, __entry->field3)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_event,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_command,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_transfer,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_queue_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_dbc_handle_event,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_dbc_handle_transfer,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_dbc_gadget_ep_queue,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_priv_dev,
+	TP_PROTO(struct usbssp_device *priv_dev),
+	TP_ARGS(priv_dev),
+	TP_STRUCT__entry(
+		__field(struct usbssp_device *, priv_dev)
+		__field(struct usb_gadget *, gadget)
+		__field(unsigned long long, out_ctx)
+		__field(unsigned long long, in_ctx)
+		__field(u8, port_num)
+	),
+	TP_fast_assign(
+		__entry->priv_dev = priv_dev;
+		__entry->gadget = priv_dev->gadget;
+		__entry->in_ctx = (unsigned long long) priv_dev->in_ctx->dma;
+		__entry->out_ctx = (unsigned long long) priv_dev->out_ctx->dma;
+		__entry->port_num = priv_dev->port_num;
+	),
+	TP_printk("priv_dev %p gadget %p ctx %llx | %llx, port %d ",
+		__entry->priv_dev, __entry->gadget, __entry->in_ctx, __entry->out_ctx,
+		__entry->port_num
+	)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_alloc_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_free_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_addressable_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_stop_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request),
+	TP_STRUCT__entry(
+		__field(struct usb_request *, request)
+		__field(void *, buf)
+		__field(unsigned int, length)
+		__field(dma_addr_t, dma)
+		__field(struct scatterlist*, sg)
+		__field(unsigned int, num_sgs)
+		__field(unsigned int, num_mapped_sgs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, no_interrupt)
+		__field(unsigned int, zero)
+		__field(unsigned int, short_not_ok)
+		__field(unsigned int, dma_mapped)
+		__field(int, status)
+		__field(unsigned int, actual)
+	),
+	TP_fast_assign(
+		__entry->request = request;
+		__entry->buf = request->buf;
+		__entry->length = request->length;
+		__entry->dma = request->dma;
+		__entry->sg = request->sg;
+		__entry->num_sgs = request->num_sgs;
+		__entry->num_mapped_sgs = request->num_mapped_sgs;
+		__entry->stream_id = request->stream_id;
+		__entry->no_interrupt = request->no_interrupt;
+		__entry->zero = request->zero;
+		__entry->short_not_ok = request->short_not_ok;
+		__entry->dma_mapped = 0 /*request->dma_mapped*/;
+		__entry->status = request->status;
+		__entry->actual = request->actual;
+	),
+
+	TP_printk("req %p;  buf %p, len %d, dma %llx, sg %p, num_sg %d, num_m_sg %d,"
+			"stream_id %d, no_int %x, zero %x, short_not_ok %x, dma_mapped %x, "
+			"status %d, actual %d",
+			__entry->request,
+			__entry->buf, __entry->length, __entry->dma, __entry->sg,
+			__entry->num_sgs, __entry->num_mapped_sgs, __entry->stream_id,
+			__entry->no_interrupt, __entry->zero, __entry->short_not_ok,
+			__entry->dma_mapped, __entry->status, __entry->actual
+		)
+
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_enqueue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_giveback,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_dequeue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_alloc_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_free_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ep_ctx,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u64, deq)
+		__field(u32, tx_info)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->ep_info);
+		__entry->info2 = le32_to_cpu(ctx->ep_info2);
+		__entry->deq = le64_to_cpu(ctx->deq);
+		__entry->tx_info = le32_to_cpu(ctx->tx_info);
+	),
+	TP_printk("%s",  usbssp_decode_ep_context(__entry->info,
+		__entry->info2, __entry->deq, __entry->tx_info)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_remove_request,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_stop_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_set_deq_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_reset_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_config_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_slot_ctx,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u32, int_target)
+		__field(u32, state)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->dev_info);
+		__entry->info2 = le32_to_cpu(ctx->dev_info2);
+		__entry->int_target = le64_to_cpu(ctx->int_target);
+		__entry->state = le32_to_cpu(ctx->dev_state);
+	),
+	TP_printk("%s", usbssp_decode_slot_context(__entry->info,
+			__entry->info2, __entry->int_target,
+			__entry->state)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_alloc_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_free_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_disable_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_reset_device,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_setup_device_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_addr_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_reset_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_set_deq,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_configure_endpoint,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ring,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(void *, ring)
+		__field(dma_addr_t, enq)
+		__field(dma_addr_t, deq)
+		__field(dma_addr_t, enq_seg)
+		__field(dma_addr_t, deq_seg)
+		__field(unsigned int, num_segs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, cycle_state)
+		__field(unsigned int, num_trbs_free)
+		__field(unsigned int, bounce_buf_len)
+	),
+	TP_fast_assign(
+		__entry->ring = ring;
+		__entry->type = ring->type;
+		__entry->num_segs = ring->num_segs;
+		__entry->stream_id = ring->stream_id;
+		__entry->enq_seg = ring->enq_seg->dma;
+		__entry->deq_seg = ring->deq_seg->dma;
+		__entry->cycle_state = ring->cycle_state;
+		__entry->num_trbs_free = ring->num_trbs_free;
+		__entry->bounce_buf_len = ring->bounce_buf_len;
+		__entry->enq = usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+		__entry->deq = usbssp_trb_virt_to_dma(ring->deq_seg, ring->dequeue);
+	),
+	TP_printk("%s %p: enq %pad(%pad) deq %pad(%pad) segs %d stream %d free_trbs %d bounce %d cycle %d",
+			usbssp_ring_type_string(__entry->type), __entry->ring,
+			&__entry->enq, &__entry->enq_seg,
+			&__entry->deq, &__entry->deq_seg,
+			__entry->num_segs,
+			__entry->stream_id,
+			__entry->num_trbs_free,
+			__entry->bounce_buf_len,
+			__entry->cycle_state
+		)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_alloc,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_free,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_expansion,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_enq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_deq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_portsc,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc),
+		TP_STRUCT__entry(
+				__field(u32, portnum)
+				__field(u32, portsc)
+				),
+		TP_fast_assign(
+				__entry->portnum = portnum;
+				__entry->portsc = portsc;
+				),
+		TP_printk("port-%d: %s",
+			__entry->portnum,
+			usbssp_decode_portsc(__entry->portsc)
+			)
+);
+
+DEFINE_EVENT(usbssp_log_portsc, usbssp_handle_port_status,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc)
+);
+
+DEFINE_EVENT(usbssp_log_portsc, usbssp_get_port_status,
+	TP_PROTO(u32 portnum, u32 portsc),
+	TP_ARGS(portnum, portsc)
+);
+
+#endif /* __USBSSP_TRACE_H */
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE gadget-trace
+
+#include <trace/define_trace.h>
-- 
2.17.1

