Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB46EC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6563720833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YajCuMCx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Qh6DuWUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6563720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeKDDEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:30 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48778 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbeKDDE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hpx2s030375;
        Sat, 3 Nov 2018 10:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GAXAFx+wRi4ET4SgtvfhMo790FZ9eionHzq8v1FQ8Kc=;
 b=YajCuMCxHA1BdzLDJ1Vc9j//NQxLHwYttwyEcI4wmBFAXT0cLwEHJT7l8WW3pb5EcOV/
 bh0gc0EmkZW+4cl3WuOwsZ1AfpiW0cJnfl/rrauYIH7C8iy48QV0qTj3/3TsT3lU+mq7
 3LFSkNiBEsppXQeh3KEN6VE8WfPzpCPQ63+Ol3iKKoCahKwNL/azQOlXlOyKC5IwHfuc
 CbqS+lXXGQgOBb1mOpwSOX4258u1Ihl8e9FLEpFYs7w1c55jU5VuyDPv5phwV9prmGRP
 7uSRld2JhYrLCoh+IytokCqomZv8FPHtZkz+W8YLM8cxymgYBmPz16rGd8nWcmcz06s4 ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0053.outbound.protection.outlook.com [216.32.181.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAXAFx+wRi4ET4SgtvfhMo790FZ9eionHzq8v1FQ8Kc=;
 b=Qh6DuWUcBtIDzKrOwUtrjm9swTwQOjFcDo2rAk9E0ikm2qBYAS5zarpoSJqB3r8YNIpseIxLZadGkokm/PSR5WQOA66ozHjlOOiKbOboA0FAfNBp23EIEiaUYBQZAe1vjR5LVcKLaCroWMqVPGa0ks1NwasmHpVLYlFY9KoM/gI=
Received: from CY1PR07CA0010.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::20) by BY1PR0701MB1864.namprd07.prod.outlook.com
 (2a01:111:e400:51ab::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.27; Sat, 3 Nov
 2018 17:52:21 +0000
Received: from DM3NAM05FT044.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by CY1PR07CA0010.outlook.office365.com
 (2a01:111:e400:c60a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:20 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT044.mail.protection.outlook.com (10.152.98.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:20 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqH5a027363
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:19 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:23 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:23 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x3000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:17 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:15 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:15 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqAfd006398;
        Sat, 3 Nov 2018 17:52:10 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqAt7006395;
        Sat, 3 Nov 2018 17:52:10 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 05/14] usb:cdns3: Added Wrapper to XCHI driver
Date:   Sat, 3 Nov 2018 17:51:18 +0000
Message-ID: <1541267487-3664-6-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(36092001)(189003)(199004)(6916009)(26005)(446003)(11346002)(126002)(2616005)(476003)(26826003)(87636003)(426003)(4720700003)(51416003)(8676002)(36756003)(76176011)(54906003)(14444005)(305945005)(186003)(7636002)(107886003)(5660300001)(105596002)(217873002)(478600001)(336012)(486006)(16586007)(106466001)(356004)(47776003)(42186006)(316002)(2906002)(48376002)(2351001)(50226002)(50466002)(8936002)(86362001)(4326008)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1864;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT044;1:K4jONP834AMkniTNAY3ZrObtfcHPlQAF8vWP1WrLrJpZt3H+klfiNmCNuRwlE0OONhBcGN6xzQi0YsS8OWbk8VIEkLqsQEvdMfy9mE22BJjV0th9py1JCe8oKZjKEO5m
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227cbcde-b34c-4a02-bcc1-08d641b51a65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;3:repsg0j8eUfKoH2t4M1H5GLNg9c0V/M6nKEPAkuei2SG7unh3YZVdzbtsDCxqF5PUCcWcHWUTQSJbU3HqqgccigzRcgJWZtIrby6Ozd/FccLceOO2xwB0G73I3I2IpxnnVTNwqXmSgqEeNz9hE5q/qIY+zmkGwkz09lEkEqIBDFCkhCBzZn8T0saU6CXjUBW6IafS+4McRJPLmTu+GgbxXFy4ppUnpe8Wux6SNgA+5pscJnmjLLOk7YNmtk1xzmH489wvOJrA+9En7PWlSyOy5Lln9aqxC+T0OxgxCcQS+WVVKubVI3eEyLXdmYzcl6HB80dYm0mz2vM5g/vMLpfn5uUVn1Ff5p/UsbzkVsnW40=;25:pNqaqsWZrCh7IQ2kc7l1/rmm4TWRbvWeCu0DvD8Bp22SZ4yzZ4+5g7yNAbljBUkkjzT9hu8UcYFNz4Cll1mtHvE+Zy6BqFj40HtYpUi75T91BLs7+sJFt5T03Ag4ExAnjKb6KSKvCNcTFVj/S4GuGZsEG2ad6mpFmYeHuu44j5AIP/kv56NXmg8wdY/24m0OZTXhKbJ3b7cjFiUaqA0cA3OsxwnvfeX+JTaJ7hqIUs/hEml6CPkt6dSaDSX46Ec+R/XAK45Gh9AaFQeiBQQpNcDPedDvZHpAMm5WNswHMV0NpBHz260RCshaz1kHeGtV8zjiNRdsFBw+3BJoqrjlhA==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1864:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;31:tymaW9mb9uON1HEU8pBj0VImpLC32UIQy9AFXenZdiRiIaWdpm33zktk0zVO7XlpsVqFhKp7Y/2g4c2iDF24MdrLsg66jhT2gXsYAsKjJHy55y7CouhTZDSvwvJq2T9BQ8KpxVbNqUEi2lnNy/CDTlSgnl9SV1HBo3pYtlcUq2dOLu4GBQuEm5hyiv6Wnn+YfkG//ihgFN60x1LmcGPbUiYovhejQdPb1LMa4dauKfw=;20:pHY41rkL9PWj3T/VK8kVu8ZMCs6f+WT02ugsuEq314f6N1ntEduQMURjUiXMPEAbE4IuPs75hWZVcUWWj9N+EbeeInRtlf/ZKpa44DJQsxeom/S/vopzA1Wt7sKxjeMgrGh/zvtSySi3yCladQaiN6qzq5r/0BXTPMjvdJwlEGaG/O7tb85D1lf5lVxcPGuCmT8a5Zm/8LVcTyxl5n5rW7oQZU8pvkG4Gsz2KwZcxbtU/0IPBJQuTlWU+r758z/saykO78t6drw9ztew1ZyWfEsS4SLaAMlx4F9wfTlB6qdx5Vg3/tOkzqmCCjWyytw4RLoEdad9+Kyc0Zxy3DGRJVBmDx7L9R6BeQV3/zLv61D+M7PwMPOmRquCzHaniXOlk4ihJuj1PAQkL8hjGJTwgdwUjUGMcGWmd8qh4jWS/Epgm2iLRE0vp1W/658JoZsh++My474WKTXX9vwL4qDA+SJ0S7Plr27uyiaRF+vAX+jAN00ksNc1BQYWpsjIGnNk
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1864788EA6B278A1B0731C46DDC80@BY1PR0701MB1864.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1864;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;4:xEjesOAyhqeXsu31AUrmLRoIoO5dNkSeX+kB+jbjTObfHQS8xZyYo/w7Xi7YU4bK5/QFcbYbEyMmP2P2yTrB7iTw2oV8wlmBw8IjweMO2hM6sGMjg2fliaEQktaO6LnvH/j2ue2beBg1fc6RHE6vJMme/p5W+zXJS7WpTf1antONphbHSLI0P9G4eoopGCVedoERdaKpoWzlLEBGu36Q1/P2QZB8BfBVFI95G6OnLI189f5jXvzi3q/0rg1z0GND0o7yPj9DNRPXxyVT0OHHxHQZQnSzZftpR4ov/v3QmKyEaErLQutbEjIuK3q2o0oW
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1864;23:DAL3K7M+/54eBHdhuuqW4DBJv/aWxFp1nsm+Rga?=
 =?us-ascii?Q?4g/NM/BkBunYnUkqPYAI23SGVxwaqKQN2q0gRc0QbQ7Kx5Ud8kF3DRSF1Hvi?=
 =?us-ascii?Q?gKv5apgY5foKI360Y1HQb4sP71gI3pNJF++29g78UeMg0SS+nxF9oLSo183n?=
 =?us-ascii?Q?aIhZt7kkPFc1NxoP9X16e0vezfLXtq9T+3aiPzrMPlrJxVYv+CwAsWBpj3WR?=
 =?us-ascii?Q?7bhRCULhaDX/0gRzfnkqgASmhPRymWPXm0O6GOOuDe1zZL8LT7U2LUoKX4pi?=
 =?us-ascii?Q?J0ELUTbRpODnsJZIpcdWN5dkKxUvdcbsENUGp4rXo+mjemUWaN6ViPn91OaK?=
 =?us-ascii?Q?7vX3yDWTnn1TYI36XrpIWKKjE+QWd90uT+2aRgXlUEk50j4AhyW1XPcNog6Z?=
 =?us-ascii?Q?+XJ13o4egMHzOsLcAUTVZaBbjMPvSgnhzsr59Q1Yztp4JDVvTdDKrKHtrsfr?=
 =?us-ascii?Q?6DKV+ofZYluisnmD4k76ZxvrQzruRQiMPJ1nvCp+iHTKbnofp+XYn3iNU/Yg?=
 =?us-ascii?Q?TmPL8izixCTBCDxX7DP8j5BlhFJjzJwgUtJ55q7CW2nX9wJ0qKhFAwVCKR+b?=
 =?us-ascii?Q?vWxsA0yNl+Lzx097c1TshI3uTLyk2zvBYlfoSgrdk1IhIOkOkRRMWgesBXrj?=
 =?us-ascii?Q?igB01uHbkggYj83A3xpoyWTVN4zzTNfoPh/nPOAI3zsD60EV7hCZJIm5KFoc?=
 =?us-ascii?Q?H7Eb+7SG9aAIwbH4SYYl1DtEOYoFN4+U8I2hWlHjEkm6tC6a+CBxT0J6LVzX?=
 =?us-ascii?Q?b518gFUcVA7fH/q1C2p+dPv4u4TYb3yMJw3gAWCt3tcI4eeHn+ZA1N3owexA?=
 =?us-ascii?Q?p7eH0hDXZMAULa7NDi+OB+qCZXwpsDeKyWg7vSnfeKsBLooB+uFTKVJC2NAy?=
 =?us-ascii?Q?QlNlamvxz37MOtonUuJnPXu5khFJJHRimqhAlMnAvXDcOhpKKOPmteL+96+D?=
 =?us-ascii?Q?QEO7NM9HQCWUb22dGg8uaiLG8BHE8avvShQoCoHN/HgfqEvSHvOCKvjuN/r6?=
 =?us-ascii?Q?gvLzMgkxg2Qw5nSoj16Yq88CLCxmGcXPoc6klu4Zneh4w96IynGAwv3myZ8+?=
 =?us-ascii?Q?2za1RIXjyigc/y5CYp2ovhPBXImBAOfHrO7UQGZKiR4tYRDxmgWTwcmvpQ0w?=
 =?us-ascii?Q?6LlPSKwxHQmMEWGAbx+tpfeyplotXK4f5?=
X-Microsoft-Antispam-Message-Info: ZHeOkrjQHfw/qJ6D1cyLww6x0zQpU1y7Rw8Ww34GqcMsKby2AjCohdbnl4NMo2HleMKzuJJJpgB9Evs6zS1LQoBlJ9CxXkyy0IiDfe+orEmNnflAHjNqweYerdd0Gt9P5ua3hsPgHUIk8hTIQ7gSav2vQp8aPxeqSJbbd8qWY7Bgp76Cb1Ct8rLRkIPO2L00K61t/TzXGB+NYXZmCNZifpn0phsiV1dJT4akZnINDjYjjf1zTxrXqSo/RhZfDiq34wz5gMstglLgF3ZuE8xBP/+R+grg2t0N36nepXXJ6qqVVFglPd0VqFAGWQhnzCN7wX6aeYJHWC3kCflPndR9Em5/aNzmxGUWlEai+j1FHF4=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;6:wVGQMqkoTqD87XwvWYjHaVfITLFNxlgVcBdgfGNDew+UEhZj41NoH/YPK++NMIaGqPxKD/EJOThujGuolVYXHi9fnBEUsBjbnOSJHdD+Wuy2zVp2XihQRgtCWSZ4DpEs7mRE/DLMnEC/6dEkegM0bpmeFQ8HMhov7eEOFx/pBSJwggdhipjFOc81NH8La+jHP2hs8vowqeoAiT2KLd7HRsqTQ2g3DAL2vsMwXdUsifD28eN6BLtxzuEt7K+sAoNYZw3B7q8jPJ2TAq6oEUSjqYhykTlW0kg2I7rUJt3pvgVT9Rt1DlPDi7OpSKFp9S1VomV5Ac3kSYpMiws7f6+xziU/HvbWlrZUgeKmvRF6kfAtTzErhQQDkcwja6KZuqee70m0ajAWkOxKZTUME5HGqyrfBqjfe4gff6PG5Jr2XpFcGTocB1aXr5t0ro/LIN72hXNpTr27lenTWCMhUI40xQ==;5:vK556ZMQbvFj8jP3Iv/7AGH4Yze0b5vhLDlhzIXnYIAWE1RPiKiY+gNuqrE4J+o9OtgzFlUaidbDuxYFHfVDLiMXqLhxA6Zn14143sOFOfh4LsnJMdlHYDwgcxkwskvaklC2aGELAJ8KM6KcmbwLeiRMT6zcbdeHZB+uSlH3y0M=;7:8X3fhLY0Dl+vZ+Fpt7Fozw2Xjj+Z+DBv4L2YiSp0FzvlDbtKwUNhYpobSC5V+do9JwHghs/p538+sxw4IWOEj3xTWZSmkGsGOTig0hqZkbhaThfr9AT7FBitMiBC9lbcdfVR2yjG9kLp7RXbpqFqWQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;20:q49kmfnEo8DuZfGbG3xUirSmev3A7U1g3+0vdMwx2GsoZdxQgmzD/YPz0hUSoGKCJS+9OnEJJnn/YBxpoRBgmMoPKEtfPLw3uLJp2OBlXXlQ0nsDfKAAR01bRKDLddyihZpVcrc5IbrTjDsDMu4BSwd/eDYrqI6gd/n38fTXPPtG7pjHJF1GsI/goFq3hUl4iVAhRDXUQUVVgG06dqk928kei24/ELfTO21TY5r0GKNEZ7LGU/mE9jXo4eFPvDwk
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:20.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227cbcde-b34c-4a02-bcc1-08d641b51a65
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1864
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=619 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements functions that allow to initialize, start and stop
XHCI host driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/host.c | 230 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 37300985e2d6..f3b100a27cd6 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -9,20 +9,244 @@
  *	    Pawel Laszczak <pawell@cadence.com>
  */
 
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/of.h>
+
+#include "../host/xhci.h"
 #include "core.h"
+#include "host-export.h"
+
+static struct hc_driver __read_mostly xhci_cdns3_hc_driver;
+
+static void xhci_cdns3_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	/*
+	 * As of now platform drivers don't provide MSI support so we ensure
+	 * here that the generic code does not try to make a pci_dev from our
+	 * dev struct in order to setup MSI
+	 */
+	xhci->quirks |= XHCI_PLAT;
+}
+
+static int xhci_cdns3_setup(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	u32 command;
+	int ret;
+
+	ret = xhci_gen_setup(hcd, xhci_cdns3_quirks);
+	if (ret)
+		return ret;
+
+	/* set usbcmd.EU3S */
+	command = readl(&xhci->op_regs->command);
+	command |= CMD_PM_INDEX;
+	writel(command, &xhci->op_regs->command);
+
+	return 0;
+}
+
+static const struct xhci_driver_overrides xhci_cdns3_overrides __initconst = {
+	.extra_priv_size = sizeof(struct xhci_hcd),
+	.reset = xhci_cdns3_setup,
+};
+
+struct cdns3_host {
+	struct device dev;
+	struct usb_hcd *hcd;
+};
+
+static irqreturn_t cdns3_host_irq(struct cdns3 *cdns)
+{
+	struct device *dev = cdns->host_dev;
+	struct usb_hcd	*hcd;
+
+	if (dev)
+		hcd = dev_get_drvdata(dev);
+	else
+		return IRQ_NONE;
+
+	if (hcd)
+		return usb_hcd_irq(cdns->irq, hcd);
+	else
+		return IRQ_NONE;
+}
+
+static void cdns3_host_release(struct device *dev)
+{
+	struct cdns3_host *host = container_of(dev, struct cdns3_host, dev);
+
+	kfree(host);
+}
+
+static int cdns3_host_start(struct cdns3 *cdns)
+{
+	struct cdns3_host *host;
+	struct device *dev;
+	struct device *sysdev;
+	struct xhci_hcd	*xhci;
+	int ret;
+
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	dev = &host->dev;
+	dev->release = cdns3_host_release;
+	dev->parent = cdns->dev;
+	dev_set_name(dev, "xhci-cdns3");
+	cdns->host_dev = dev;
+	ret = device_register(dev);
+	if (ret)
+		goto err1;
+
+	sysdev = cdns->dev;
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!sysdev->dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(sysdev,
+						   DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
+
+	/* If setting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_no_callbacks(dev);
+	pm_runtime_enable(dev);
+	host->hcd = __usb_create_hcd(&xhci_cdns3_hc_driver, sysdev, dev,
+				     dev_name(dev), NULL);
+	if (!host->hcd) {
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	host->hcd->regs = cdns->xhci_regs;
+	host->hcd->rsrc_start = cdns->xhci_res->start;
+	host->hcd->rsrc_len = resource_size(cdns->xhci_res);
+
+	device_wakeup_enable(host->hcd->self.controller);
+	xhci = hcd_to_xhci(host->hcd);
+
+	xhci->main_hcd = host->hcd;
+	xhci->shared_hcd = __usb_create_hcd(&xhci_cdns3_hc_driver, sysdev, dev,
+					    dev_name(dev), host->hcd);
+	if (!xhci->shared_hcd) {
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	host->hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
+	xhci->shared_hcd->tpl_support = host->hcd->tpl_support;
+	ret = usb_add_hcd(host->hcd, 0, IRQF_SHARED);
+	if (ret)
+		goto err4;
+
+	ret = usb_add_hcd(xhci->shared_hcd, 0, IRQF_SHARED);
+	if (ret)
+		goto err5;
+
+	device_set_wakeup_capable(dev, true);
+
+	return 0;
+
+err5:
+	usb_remove_hcd(host->hcd);
+err4:
+	usb_put_hcd(xhci->shared_hcd);
+err3:
+	usb_put_hcd(host->hcd);
+err2:
+	device_del(dev);
+err1:
+	put_device(dev);
+	cdns->host_dev = NULL;
+	return ret;
+}
+
+static void cdns3_host_stop(struct cdns3 *cdns)
+{
+	struct device *dev = cdns->host_dev;
+	struct xhci_hcd	*xhci;
+	struct usb_hcd	*hcd;
+
+	if (dev) {
+		hcd = dev_get_drvdata(dev);
+		xhci = hcd_to_xhci(hcd);
+		usb_remove_hcd(xhci->shared_hcd);
+		usb_remove_hcd(hcd);
+		synchronize_irq(cdns->irq);
+		usb_put_hcd(xhci->shared_hcd);
+		usb_put_hcd(hcd);
+		cdns->host_dev = NULL;
+		pm_runtime_set_suspended(dev);
+		pm_runtime_disable(dev);
+		device_del(dev);
+		put_device(dev);
+	}
+}
+
+static int cdns3_host_suspend(struct cdns3 *cdns, bool do_wakeup)
+{
+	struct device *dev = cdns->host_dev;
+	struct xhci_hcd	*xhci;
+
+	if (!dev)
+		return 0;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	return xhci_suspend(xhci, do_wakeup);
+}
+
+static int cdns3_host_resume(struct cdns3 *cdns, bool hibernated)
+{
+	struct device *dev = cdns->host_dev;
+	struct xhci_hcd	*xhci;
+
+	if (!dev)
+		return 0;
+
+	xhci = hcd_to_xhci(dev_get_drvdata(dev));
+	return xhci_resume(xhci, hibernated);
+}
 
 int cdns3_host_init(struct cdns3 *cdns)
 {
-	//TODO: implements this function
+	struct cdns3_role_driver *rdrv;
+
+	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
+	if (!rdrv)
+		return -ENOMEM;
+
+	rdrv->start	= cdns3_host_start;
+	rdrv->stop	= cdns3_host_stop;
+	rdrv->irq	= cdns3_host_irq;
+	rdrv->suspend	= cdns3_host_suspend;
+	rdrv->resume	= cdns3_host_resume;
+	rdrv->name	= "host";
+	cdns->roles[CDNS3_ROLE_HOST] = rdrv;
+
 	return 0;
 }
 
 void cdns3_host_remove(struct cdns3 *cdns)
 {
-  //TODO: implements this function
+	cdns3_host_stop(cdns);
 }
 
 void __init cdns3_host_driver_init(void)
 {
-	//TODO: implements this function
+	xhci_init_driver(&xhci_cdns3_hc_driver, &xhci_cdns3_overrides);
 }
-- 
2.17.1

