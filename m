Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CECC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kHC2UQxO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZJU0eTrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084E22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeIHCTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:19:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727639AbeIHCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:19:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87LYsgb005352;
        Fri, 7 Sep 2018 14:36:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=I3NzuDb2NmXKawNxj/mtPlFc6dps7q6TPwQK1NgB49k=;
 b=kHC2UQxOwBHDykkFvCpLzsbzpF44sz6VQXsmJl0RXlULsdpJkjd/Ixf4/xhCMNSJqB9n
 2vWw1RF74ApRspouyOIuqZwMArkvMA+8PGBhHqQWGUcKUzyjnnmMNDlPwTbFO5LwSnLo
 goGlCuYuQF+loqXzuoMyK2B49zk+fVjsiGY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mbu1ch7gg-14
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:36:16 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3NzuDb2NmXKawNxj/mtPlFc6dps7q6TPwQK1NgB49k=;
 b=ZJU0eTrtCultbeOMa1dKCnIQlA2ALL4K+x6tNkMDQT8hW81v2SX6PwLSRHWT1wgVQQ3PD+6LyErSbKMG5N2OYMsbIqxPdOCYiQhfKF0UZ4J2MUPl4kO0DVyURrgex6w5zgF04anVUa2dMcDARM5eToGgJBVpF8kDG7j1FDJ39F4=
Received: from vall.thefacebook.com (2620:10d:c090:200::7:36ec) by
 MWHPR15MB1230.namprd15.prod.outlook.com (2603:10b6:320:23::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 21:34:50 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: kselftests for memory.oom.group
Date:   Fri, 7 Sep 2018 14:34:03 -0700
Message-ID: <20180907213405.31574-1-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907164924.13789-1-jgkamat@fb.com>
References: <20180907164924.13789-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:36ec]
X-ClientProxiedBy: BN6PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:404:121::27) To MWHPR15MB1230.namprd15.prod.outlook.com
 (2603:10b6:320:23::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e43a0e16-d868-426a-75d7-08d61509bedb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1230;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;3:EyO4kfcqByQLgAspFo9+xLspIlBsvdAYp2fDhSbj74E4bo6vq4FL+I9CfqZ0hJPV+ZawKeFtvSugHYe2a9S9pQsgbXVbo0PYQMtXeGNUA51DGtnOASM9GCrZnuaSerhpVM+IHBR5aWZytQrvup1xlv1dvSuqTsKtQMuRZOv52ZHx4CcmmZCVFvQ3DiuUPnroIAaOiMTZPdPFx5ljVyYRu5lIdi/6WLs3hOxfxI2NZChEWJwm8spyIfeXET1cBaMF;25:U9nLBU6MeQr+P/WXneXzwlxhKNXdUt+fxAOage+tn/5TckyfEvxIBbpUJ2CJSJXZR6LyYhx8JTX6bUL7bo/I2itUkmDS8StapqA40MUyNslsdmoaPSDQW97wwNn3gIE6kWQfQs6BEi6cwXoef2Vy5CcxrxUYEckH7k7p6/zQ5md7oMPPiv1S5Ea6hKiuXjSmrWtnLqaQUIonEld+8W9kW0YlijpB0DJK1xAZ4N7eFOfDJ4Ez/wBVTpgN/yfGHSlb5iZ23F/ihwg+46UXOdgC4v/PZdtHVBeMggsCpbjupmGPiJ2JbIyUdf6gmgC5E6zPu9mrxakta/6Ahb0BBJzaog==;31:9FCc077BdPiIcD9BMqAliYuZyJ7sy/B3UBuOdck1sCTQs40RefGDfn/RQnyhM+IjYekEc4DUmw5hcgrEbVhnf/KQRq5xstmZlWS+CdpilMSoI1O4ViaOGu9VVsg2da+cubOHwkJHgrc2cI3Jm9c1y6kUB/fggTCkNLz1L5Bho5n28LKh+7NNayie8dfo0lY+tyNZnS2lUhpx5ojvVNAm4hKVlAjEVHtoTYEIzg/zHLc=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1230:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:5e26uP9vqsIrswn4VaNrdph+H1PRrcONwFns9O907DJ2Z4eRIpaiUAjlDVrGnXOj0tKBRKns0E24PvKAwNkbpqrl8gWPZmiIuAbiaMTzjUKWhIvX2C4vgrWA6dolswFGUu/xNLsxQHCM2XS+YzRLl7BUc5qU2udhm0tEJwETogZRMthMWYuc/qo6jfk2cXQLi0EFoTiNfGjdl6it+WucKnM8sUoTfRI0f16xD8Z1QDaXimLLtHjJmOi1hNdyK3Tv6FlAPU/IpQOCTuAE/R2EMcXu1VLCkGaZ93dPloqLSw8POipiGL4pN88u5uh6hvwsGcKDyr5bR9l1PYTWm/VM+hC+KXqzy5Lyd2wF59bpbv7jCETAKbmCC4QcRd+iAwZSaR7nPjyiXLfZtwE6qf3g2AQT+K9SuKmmaTug0T3WDJdunQfsM2yUMl5VCCTH3/9T7OxaD1SidKddk+yMzPVXvYh/QLW1SnTarnlBwacp0/YIbpFNtxt3K6Iv+nXgvSo8;4:bxNY38CC6YW1M3W5e9mqtcZBzT8n4/mP4mC45j24U83DgAJWQeHnLq08B2D5NksvxCvZ1m7arNPG8VYq2/CGvQgMRBPbTrMNTWcE74GPikpQlNxX7H6m/EJDi4pn7zJLdMGYStksr8S3ZotiFD2I2bDC5qlY3B1LIX8/ZRC9dxHtOeHmNETlpZ5sDy+6Xsnj0RWWgx+PLUYPvBUtLbTwyzzYOcv8DbzmzwnSsfqPL7tBGPOmVsuBytAdUlqwJHtp2BUcjXY0fNxTAonPpV8fjA==
X-Microsoft-Antispam-PRVS: <MWHPR15MB12309058D8F61306EB452D7DCE000@MWHPR15MB1230.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:MWHPR15MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1230;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(446003)(105586002)(11346002)(53416004)(25786009)(69596002)(52396003)(76176011)(97736004)(52116002)(16526019)(51416003)(85782001)(186003)(486006)(4326008)(47776003)(478600001)(54906003)(1076002)(16586007)(6506007)(316002)(386003)(6116002)(2351001)(39060400002)(106356001)(558084003)(50226002)(476003)(6486002)(2616005)(5660300001)(36756003)(81156014)(7736002)(305945005)(9686003)(6512007)(2361001)(50466002)(53936002)(81166006)(8676002)(33896004)(6666003)(48376002)(46003)(86362001)(6916009)(2906002)(68736007)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1230;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1230;23:oY79j25DriGR0XWjc2vJQkPcEkg9zzLQIvvatIbqL?=
 =?us-ascii?Q?0YRrsHxKymYju+H9CuqVsqL/HqIBxqLnMIR4kwxIwNRJw0Y0w+DsZ8nhLeqA?=
 =?us-ascii?Q?XRTBv7RRZuT4Ez4D/CPgHRkurPVkjaLVBE/RRJtWFI6srRn5BanrFmOS9gWV?=
 =?us-ascii?Q?qhXMc7mJaKSCPZ76CkySlDDdTyGcFs44q2cTTZi/8vNtTvK6Xd6TS1XCfoTI?=
 =?us-ascii?Q?M49E6j9KsDHScFSiCuryxc8ZqMgqNvdELuftz4RO8dnoNwgD3vkVZBvTbKSB?=
 =?us-ascii?Q?0Ush8c91j+Ajrb29yqE6s7bqOfF0CRP2tHo0k/BvHrySOzqLX08IxYXjCh5q?=
 =?us-ascii?Q?eFNHKw76ASEm0l0PNqAQoHsRPWkZMiRlKuMC/4wBbipXJluvLk50vhjySvVa?=
 =?us-ascii?Q?oDuibZZBWvla2ShjkN4ToULaYpUNcSEZdBprsjVIJg7HRhjCVslAM0jxitGh?=
 =?us-ascii?Q?y7I3B1b0LEFktuhy9Dk4dE4VKWG3nk4g/QMVbnDZTCdVGBQ0mh1ojA0ERhyl?=
 =?us-ascii?Q?xAgA+3HZtHpXIKnVMOTenLexK7/B5/7TM35k4X0CVbVZ1J1J7DaX0jhndZuz?=
 =?us-ascii?Q?b/BSzPijNwSggQGXGN6tmRJe3xR7eLcMdLbW8qeeeLAglxO5Z/NoYpkvXOdQ?=
 =?us-ascii?Q?rOy3+Bgn14OiNt5T9Q72navGHIQmV09JQFJ/hsXSRwstClNldlg1En4iwsMe?=
 =?us-ascii?Q?ib5O/TRSj8w/aZAdwE1i/bZsJkjURQ5F6czC75z/NNypCbzcmWrilMVnrZzZ?=
 =?us-ascii?Q?HLZK+LaAVjk2fSXGf3A6Mw2JOhJx8Qz1vjXA61sFMWfobuatp1w+SxqfzsrJ?=
 =?us-ascii?Q?BsRBVcqlT1qsE9QtSmtH74QUCMm1R9hcaGYGexlJ9o7rBdzmE3QmwFkJ5/0A?=
 =?us-ascii?Q?cjtaJZ/HhGI3CsNCpHIVsrxK3fuxEBkhk+QT0zkazaNPEcto3LZqQ/xBGJOQ?=
 =?us-ascii?Q?r3U0CalNAO2e9uYuGd0eO0TwOD+e56KhXbZqt/cZ+GBhOhcNYdELHnNB+4XN?=
 =?us-ascii?Q?tAdUpVKWtOGLTwJ5VqnozUAmt1W2FI8ooLSAXs2xLLSzlH+DND6HpIS3LUb6?=
 =?us-ascii?Q?Oc1mrJIh+HgiZZscaf2xU7HmO7LwXU6yic9RtX+e+Gz8jviq7g4yg9AjyHkL?=
 =?us-ascii?Q?0CkZo+lDOt6+ceMu/e3EHHTTTuUvdrBRDrmGe+QoDpaxjvg2NYT2wKjbpAsK?=
 =?us-ascii?Q?56+sm9LaMdBwpt6l/0LTPJYYTnOxMGmxR5IZyf0G4V9JOpePuREq/vjl2zGl?=
 =?us-ascii?Q?WetYyNWHjkmmliXvShr554EaL3A0+AkdcnhAeqmESrEAF2ZZnp+ZlehARLtx?=
 =?us-ascii?Q?dLC3zCyXbJJV3xrxg297s/gHrEz/+EXmIXmK5C+67EEjUcJOD91eHZs4DNbo?=
 =?us-ascii?Q?n/6HBrXQiP78OBm8pRXfodcEHg=3D?=
X-Microsoft-Antispam-Message-Info: 2sS/5hcsxys4X8Ox7T9vtOujWgjzk4ej8NZuogMVvNGN3cps1CCdea8nhfdWyeKiiIMLOdzmxylwWx29vetwnQbjeeMwCXJ6HB8Se4wPhXnqiIwPuoE3MP9jDaSILP+OkpNk5HjlyZLDqephDcN+PpRdanZefbAR5RLSr/LMaD2LrTzZ1JfERNjNZ9YOj2QM3he8SXXqktbfWN4Owkv4Awc84W8JeEhoxY14rzDCmK/dgaF06s0jPfEAu5A4UapxZefHCj1OFNhZoiAJTyzUZk/c5Fqgjumty713rFTqjlgOiHJq9KuKif1BCy+VIYmHypMdsBsnRH4N2rywO8L3h+4cd1mUQFrZH5IOLB1jG0g=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;6:FdEE9CP59o2s1hRJEBMBQXbpD9zNRLj2kkkiiIwjqWX0bTjW6398gTR485iO/UxImYVdrFZp37KCXGDcAtFO+Fg8P9hidG2nMt2lCOpRD1cTRQiQNltumkeKetVOxz291p9Sxa3P3AhTLn6LHDrKTx1SHo5qtKtAaVrg5GeAVtKZGLyp97fOtyZamYpMSsH3WncRgzEoY4+mPx6C936UU5EpAMzUvHVStszM3fpbqV1wXb4iL4XgHLpzvcur4B/OW0612pqXy4/r9ZZIpHEZRFsmE1jSdkDekR/JvV2kln6maztSlKTXfKYZYdCDAAXp7Mbe3A7h+N90/FKBkyw1Wu7Z+E9NTw0cz252nubkLtWSBHAFviZt3e4WRLkBPY3S2zxHekkE+XG7FE/GfoJOph8vth4rpeyFRtPING1seW/8sHgDtDtZqZNUFDikU2PQwcb/POMqshJqpBWbycEqbg==;5:zi3H3V4FvBu/yIH5lUH38egEUdlanwI38jYLXcfLc5G0H5aFeSlub2o4EG5703YUAA5hNIw3s9mvNXvfE64qfbMxGRiKPHimf2GTf71EbBk2VRMuwgXYnhhE/dv0uZRd3xLVt2+U+41z9IYQ57JtPw9aXLG/Kq5TVsLKhg/PtQc=;7:FtJKpnXmr0CWkC58aBFZiUfwu11ONDIjwhUKOyaF1eYlEqXYmq5s8r+GWvSLTdLFZxwzJEqjA0tvQuAkIUlsE5l3/rcbKWuQEK2Icq6nPF24BpffUmuAIGRoMss+QQ4pVZgTcjHKi8IoPhB9nQOpZmG0o+BlaR/q9C2sjrogLypfzP/H8JI9Q1T7akVtEGmlWeLlrpjYBvaRwdpbAjw8Ka7EisWjPSwY1AVxQ/s5GIQmsYldpiDK9obKCC6oqBCA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:27KcmqHRYfVdv0iVt10TWhViAMgjQO9wt7OAKitLo/R/tRFX7j6JAryJFU+oI6KGspnFu434sCRWAEiAkX5VuZ/AfU/Nk3mEL1mi7Mi0I7So247afTuP37H9oT8/xx+HRpDnLa7jUJVoAqb3NWtSvxBfDUyIRglYH6hYECo9QiA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 21:34:50.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a0e16-d868-426a-75d7-08d61509bedb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1230
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the third version of the patchset.

Changes since the last patchset:
- Updated commit message of first patch to clarify fixes
- Add ack from Roman

There should be no code changes since the last patchset.

Let me know if any improvements can be made, and thanks for your time!
-Jay

