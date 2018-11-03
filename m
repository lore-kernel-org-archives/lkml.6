Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D475C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D876120833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BB8vnxYi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QgCp+lCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D876120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeKDDEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40138 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728855AbeKDDEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:38 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hmk9l013634;
        Sat, 3 Nov 2018 10:52:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QjvswzZgBMyXc+87B9HrUVb1jt4NPqkme0rDkgzycsg=;
 b=BB8vnxYi79eKTpZLo/OOnsqiyV8IGHBhkkxWs0GaJh+KnuAT37h3a78XKbcB+z4X+n8G
 DU/teQX6eDcecwl04NgLORF85M1SfjPErkGUXI9dpsFMqzcrQV/TN1RnPoLgwMW2JyOk
 lKKhkWMI4Zsfq5tWGVSLLm8iVQgMI4OvWXLv055DOhe5ioQENWcYc72q7nTL6+zrU/2b
 FxfErdHqfrL2+hArg0btCiiR1Z8CR4JW2mBNf2VLb/j681+25O8PmZy0lp0Nl84+JnIz
 qaeUuBNsXQKuIe/tnuTacwg0+hUglV2nZVla61XhYMhExF+0T1DiKBmAcC+4YDUKDXH+ +g== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0242.outbound.protection.outlook.com [216.32.181.242])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjvswzZgBMyXc+87B9HrUVb1jt4NPqkme0rDkgzycsg=;
 b=QgCp+lCFOwJO8JIPMhgqT8c+ysFY5ye0nQGZxKDLT1eHZICxrBVP9VBUo0aiaNRz8Ahc5D6jn7jGGpqs8b6ex7z2/xtHf7zVoLY7N0gvq4dr4EfAzE8Y74r5EXPglUqAhf4zgxxbIVYMTrIT8s0hh79Q4yFj1ovKB30aFD39/B0=
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by SN1PR0701MB1869.namprd07.prod.outlook.com (2a01:111:e400:517b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.25; Sat, 3 Nov
 2018 17:52:28 +0000
Received: from DM3NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:28 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT047.mail.protection.outlook.com (10.152.98.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:27 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqPd3009434
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:26 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:31 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:31 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9xA000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:25 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqCBh006540;
        Sat, 3 Nov 2018 17:52:12 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqCK7006538;
        Sat, 3 Nov 2018 17:52:12 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 12/14] usb:cdns3: Adds transfer related function.
Date:   Sat, 3 Nov 2018 17:51:25 +0000
Message-ID: <1541267487-3664-13-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(36092001)(76176011)(126002)(26005)(305945005)(14444005)(186003)(105596002)(476003)(2616005)(11346002)(446003)(36756003)(486006)(2906002)(87636003)(106466001)(51416003)(50226002)(478600001)(2351001)(8676002)(8936002)(26826003)(4326008)(426003)(5660300001)(4720700003)(42186006)(54906003)(246002)(16586007)(107886003)(217873002)(6916009)(50466002)(7636002)(356004)(316002)(48376002)(6666004)(336012)(86362001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0701MB1869;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT047;1:kLh6r+9f0C9Em22nvodKPhyJ059tDdAmSN+kBHWhkcAdhWemq7uLVq8xyPt3YitU8lxOuSMdwq0KS4Z4xUbe3INrUfBVKsk+fSOH3PN2Uu0nPTLE9DXkhLQPO0P7bH2N
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cafad4d-d827-4d0d-3d74-08d641b51eca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR0701MB1869;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1869;3:6s3/bIEaETCj7D1m43rAjAFil7IoEFesdtCjMHPXRrqA7c+6ueuoHSluRq0df5Rot5cejdkCHDUkpuEf3dtAL/Q6AbrNgPWasi/fPJy/6d0BxhWJqMG9cIFdSdeEaCl8XFN8PKuSkYwfdk4WI/z2RVCg37I7UVsiL9JFCCqo/LYdIfxph+GnyGG4xpPR2SlJ6JXanKeXKKMme6JRG5bPhArnWhROR9C6Ai3OCvFDzMweXpeKjFF+MradyE1SSIpbYuL5Z5UHx4gK3g1Cxwn4aGRcesMhMBUbg4HftR5zHEfH5HorDdlp9SU4xqfeiCQDfbK3hCRSwBEYxx/hq5yNY6a5uRO5qAvvifTcqqo2J5Y=;25:OzVdknTgis8sicEXOWBwlC7Tv4dqjLqNIOapWZ2XoO4m7A/eelzwxeT4mHdngJksJABO6gNhzOSXApo/Fp5aIRJYLWjIpIADFGR/+cwaaD0pDU6A5OZhWY7EEJNBeJ7LJW45SMLMBjEOOV3LdeFxCb1gCmtOE0tIyzujtb7fZunzsTnrWQ7voKIY+kwZfOGq2CIGv8eGAY465J8lkvsZQ09S5GOYuRUDOUofKsO/P4ftyqGdFJlmoJBSJLboy4bJ58mXm4VuGXqYJyOAs6LKnlA19SulH4JnI6NX+nkXFjamWmfts7h1kFW5V6wgmxn7fFJUrzxrxiCXhA2rV2qZMg==
X-MS-TrafficTypeDiagnostic: SN1PR0701MB1869:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1869;31:22Q0DWeRTU00oQvomuevatBemH+skRbggCmyPhOoLwdlfAm4jlRAfgl/b3ALTbJq556nCtNC4IVjttlUYGCAcfEx9qffqOqqW962ICa4BkMaZB/bV2i9LEXEf4/8wrWs/RvSAObKmdLzkjUMnEYdiNSssWiGVHSQ4clxkADDgmmICvSM4GR4+4eBPsPEvzn5iiJfFBJV8uVYYaqvdSp7/sqf5GziTDORTKOUnDvIvl0=;20:lYRl3yQq3JA2L0V7tmFcJ/nU7TKNasIQ9A+aqZXVkftlnY4/GAoZynf/v7hy3U+Fl0x9R8bdQt6IKLoq4F0F0CUyBpFUzGwBrnPqpfDq6nc2h6sVzQAYW/i3uBO4Fo8EDHAq7DRkal3IBgIoffMjh6d0QYgethmghRAVowpIDfkdarB7J4vxAc/iXiKpjnw3OfOB712WuiLozHWR/WzBC7ZP71dJO73i4Zicvt+KyHgyqaCm31jUJVf7U/Ue/5RPF4SzfScVjkN4kmyCJlWjwp+jkTmA52jd1kdN5LCxuMp3UHizY7XivlFFJ92TI/5QS/7stEUzbmvrpGJSG2sey/k7VNpPMZThdq8klxGPrn6GDP0CtLjrfDYhaNQEhM+K9nRbbRyMkFLFFJaDtgAl5tGnwqpMcn9ce+79y4UYISW3vxCcfiygoIp4Jvp8cwoeFp6M7K4C4ddYWbydS3VRxNwFAP59gdVgGy37/qUeSw6MJdR5bF1CslQaqPNuEuCw
X-Microsoft-Antispam-PRVS: <SN1PR0701MB18693060FA286C7B761F1F59DDC80@SN1PR0701MB1869.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR0701MB1869;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0701MB1869;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1869;4:AgdVobqgmjGxIwB0Fw43KaPVZc7ekq5rcrp96q/4rNcIoQeTEKS6W7yss2nFEgFI2ooyj7KkeboNPlMFFLcvQTHIw6iBtQGGqMBrm2i+kM5pTSU1j7KmwPwLxUwl0fctVsz7HoYLMEb59ZOc9dec00CGk9zG3aUK0+Hs2l1DqQ9ZRX8jfXlBTvFnGU9fgaoyBU8FtLVSkrrq/BhpGJ9s8bewU6JzIjX1TDP4j9dD2YUoWiVjHyjdsHXxz9ZgkZEfubAtBmO4qP+fUYKkfQMhNN2JOiN23bHDeADFfw8kVAYkKJEk7acFmsodxQ5xtGBy
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0701MB1869;23:GpGoPodvGn2tQvGy/HGcKDK81yYqYMSUlEhgure?=
 =?us-ascii?Q?xe78Wqn0vEDs7WfQolYLV5qprqWWPE+nH2IRD9rp4xa5noEA1429hLCrdNfT?=
 =?us-ascii?Q?2R9MbvviaMGIgw/N+OgqOfaqVmHOAdWKBNyTklpC7YbhmR540K4YEoy3jfwh?=
 =?us-ascii?Q?zZWoXwEu3B3/lWLTitmoWr+5gkdM3hOUerKZkDHgOGeCJWPQZVq4h30Hd355?=
 =?us-ascii?Q?xR+s1NnW7bCi2KegP9Zs9Zg8urGVll02EO6BRYpbAPkznzw/rvxIZpN760Et?=
 =?us-ascii?Q?i8lM6tz7DeVpsPOK2XwvS7nuGD9ZUM2ip+kOJnLLJTL4Z3fQo7VWh4XYbC2X?=
 =?us-ascii?Q?oSxChRhg3TlzB1x5Jsy3tvsJa2Sap2zmJm0OJuQ+pj8t8DSO0L0CUgSPBUlt?=
 =?us-ascii?Q?TF2sToWhqniAjWQJZJkonqJizUELkbZliVbI3adnMFHbicqbfCuzd2UivpLP?=
 =?us-ascii?Q?em3Wj5AMEbZKpzoJd4qO4QH1Apq/fH/zAlX4ZoEvjPLHPDus95++4goxeb1q?=
 =?us-ascii?Q?rptjW1CW1SyvXO/Lvmq0h6RjzSBx6Pz7VNzIYM8GQ2rBKQuPtjlc74imsRS8?=
 =?us-ascii?Q?s10GEHW4Ct6WRcUpZLYkW85U0MidrvzRs6UWD0NjZ6KqDuCzruW4NUkZA7GO?=
 =?us-ascii?Q?lmSdMEnnmYIO0K/H2zhYZ6sL5zR0RN1qx8PoGdfzLrLN2uSX4J2JUEikdh/O?=
 =?us-ascii?Q?awHXF4gRsQMiANrIrr+AD5K5T9HaYdNhgHxNxOohEVZDfNpazUE2Z1di6Yzr?=
 =?us-ascii?Q?tZtrg0gpy7CYXz0Ry6cylcEn1cUiL32BUJIuwXJ8GK+zdF2IIKVMDRhix5T0?=
 =?us-ascii?Q?xDJc618VU2WITGSZNqiMJlpvnX5KTQeHQYoS++9GnPd2vBBb4pzja2dcgAFS?=
 =?us-ascii?Q?J3tK7Q/j+B5ljBm9KtpXq3TNhdANSPFD58fTj+4pPna+rfXwirS8rwUyoIFb?=
 =?us-ascii?Q?F7wLyM8LBWbNv9ICZfX76VwUpjP4J8Sl/AiyyapQVNJPIAA7msY+C1EEs0va?=
 =?us-ascii?Q?u52GOl4VLQXF+wshmOJFC8NNecXBZYXLPNK7/asjKJV4dz0+K25vuOQ0BE57?=
 =?us-ascii?Q?RX85KMP1wHoXT8V5pq3uXBdMC807D0Bq6P8UPM9b2lT8/JJi63U3QHw4Guuu?=
 =?us-ascii?Q?JuMwr5rGo3vlKmPoa/PN+OwdZfJm1C3d+unXLVFG7Fvjpn2QEeblFag=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 9EtAZ+rbRAkpBoxnQkk2vQE5DpqjYEYJ7H2PX/KCLrXRFq35Nr4CG68ANnyCOCiayhX48X2NWz/+1OPICxe/8SQwHJwdVVBvkeVX7RE7IaJSXQ9dSJKQJjtKv3quguoMhVtYqnPdSDoB3PZV9Ua22Z0uvMhYMVlGscMm4N8Alz4bVOtT0lBH+boQD5QCoxw654H/w0E/z2vfkb+CXvhq4xgw5aHpJ7S9x+SBuln+tBAkbTst/H3geFeGoxObfM41m7zgwGRvkkOD4ceq4uHoj9033BC5LF8cRe/lTtICZXSVGX/7L5TE465gquglvT8+Y72WLGo2qi+SsVLm2QISfNGJhfQoIKvh/z8EvRvkzxg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1869;6:iR8LU3WunnlFlks0ZzUzlUtyPmnMuzFngafZaUUNH2ttexmqMpHucYJOCuG2JmVObJthHdkeYmfSyLBo0jXFSaj8ZQNsGIaw8kaj9dzXLDMMyajWd/86VFxRqEo0X8bn6GG1aR84w7ekowod0PWhw9icTYdDTQsggFCCPGj2aRn1e8QxjcA+Inhx1zcqdJivqCXwJtBLR/a7Baw5p2BeLtTSS+UswJ6PNHUdmA+GnmaCYgAhJfqtM3t5RfuTzmtPUCmzb17l/vIKTbN/iiTIvF5e7xGRJAuy2OBHwD1Ve0btF+qfdFN4MpyJKR4YJbIGeR5fuGw63JE0P/dF40w42q2WA3y4rY9oKONfCwgSgph18Z9LMCGhgyTKOwIbDj71vz8T8ZDopfzWsi0JFeOy+3Tc1/kb5nn5f/eLB/qqoEhM9qrKA4BXOa+EdmKQmUkLMw3tP8h7kWh79LphP2EOmg==;5:6D/DNu5DB6ZMncqOtRF8T4ZiTend9H8sFY1h3IDPF4A7832+ex5EwfVO/YrKtsrnd/YInVeaZ3nHAN+er3mATongCG1TDDN/Ex2xwF4cYTblWU2R8tXmzIq73ACa3P5wjb0bp//k+uxxyQYzfTh1RCL7dKQ8Yc+ywWO7JDnfAfc=;7:ori2bmB2WPcPkKshr0Sywm7UkKY0vc3NZJk1axbW8kzsP2UpdEsNmRAcwuwsQMWuHYMgljW1QLjBgAG1Gwhw4ssQa+ZmZICnHOuhqs+HAPYVAv7pUAI9ahmXE6ne7SaAAzkFJgVcQ1hzk1tueHNRqg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1869;20:dKBg4sx5dU0Kwbmf4AtRwxaK0VVdXOAY0IQNs58WOx71c6Kp9nQaRDlC8Q9HzrMx78jGaW+PFrHa+qosO/AQDmrucCdlvMQjTAfYt6i8z/k/RNZh2Q7QXv9MyZAJGG1Z1kn8C2ZcZqf/XtTFwQ5TXufxnZs+IEjqIubrl683tfeaIvOOnO9xu+dmZPWgAqT+DnOyxaCWYwAxX3bchNHLt/0IO3HUIkMm2dFMFdbKFWhEfSTpG66gqPHpJvXKUV/K
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:27.6741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cafad4d-d827-4d0d-3d74-08d641b51eca
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0701MB1869
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
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of function handling transfer on none-default
endpoints. For handling transfer controller use cdns3_trb structure.
Each transfer request block (TRB) contains data buffer address,
length and some control bits. Each transfer can consist of many trbs.
Such group of trbs is called transfer descriptors (TD).
Each endpoint has own array of trbs that make up a transfer ring.
The last element on ring is reserved and is set as Link TRB that
point to the first TRB.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 235 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index e5c4d9236f07..905cad1a8229 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -229,6 +229,45 @@ void cdns3_gadget_unconfig(struct cdns3_device *priv_dev)
 	priv_dev->out_mem_is_allocated = 0;
 }
 
+/**
+ * cdns3_ep_inc_trb - increment a trb index.
+ * @index: Pointer to the TRB index to increment.
+ * @cs: Cycle state
+ *
+ * The index should never point to the link TRB. After incrementing,
+ * if it is point to the link TRB, wrap around to the beginning and revert
+ * cycle state bit The
+ * link TRB is always at the last TRB entry.
+ */
+static void cdns3_ep_inc_trb(int *index, u8 *cs)
+{
+	(*index)++;
+	if (*index == (TRBS_PER_SEGMENT - 1)) {
+		*index = 0;
+		*cs ^=  1;
+	}
+}
+
+/**
+ * cdns3_ep_inc_enq - increment endpoint's enqueue pointer
+ * @priv_ep: The endpoint whose enqueue pointer we're incrementing
+ */
+static void cdns3_ep_inc_enq(struct cdns3_endpoint *priv_ep)
+{
+	priv_ep->free_trbs--;
+	cdns3_ep_inc_trb(&priv_ep->enqueue, &priv_ep->pcs);
+}
+
+/**
+ * cdns3_ep_inc_deq - increment endpoint's dequeue pointer
+ * @priv_ep: The endpoint whose dequeue pointer we're incrementing
+ */
+static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
+{
+	priv_ep->free_trbs++;
+	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs);
+}
+
 void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)
 {
 	if (enable)
@@ -268,7 +307,27 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			   struct cdns3_request *priv_req,
 			   int status)
 {
-	//TODO: Implements this function.
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct usb_request *request = &priv_req->request;
+
+	list_del_init(&request->list);
+	if (request->status == -EINPROGRESS)
+		request->status = status;
+
+	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
+					priv_ep->dir);
+
+	priv_req->on_ring = 0;
+
+	if (request->complete) {
+		spin_unlock(&priv_dev->lock);
+		usb_gadget_giveback_request(&priv_ep->endpoint,
+					    request);
+		spin_lock(&priv_dev->lock);
+	}
+
+	if (request->buf == priv_dev->zlp_buf)
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
 }
 
 /**
@@ -280,13 +339,185 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			  struct usb_request *request)
 {
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_request *priv_req;
+	struct cdns3_trb *trb;
+	dma_addr_t trb_dma;
+	int sg_iter = 0;
+	u32 first_pcs;
+	int  num_trb;
+	int address;
+	int pcs;
+
+	if (!request)
+		return -EINVAL;
+
+	num_trb = request->num_sgs ? request->num_sgs : 1;
+
+	if (num_trb > priv_ep->free_trbs)
+		return -EINVAL;
+
+	priv_req = to_cdns3_request(request);
+	address = priv_ep->endpoint.desc->bEndpointAddress;
+
+	if (priv_req->on_ring)
+		goto arm;
+
+	priv_ep->flags |= EP_PENDING_REQUEST;
+	trb_dma = request->dma;
+
+	/* must allocate buffer aligned to 8 */
+	if ((request->dma % ADDR_MODULO_8)) {
+		if (request->length <= CDNS3_UNALIGNED_BUF_SIZE) {
+			memcpy(priv_ep->aligned_buff, request->buf,
+			       request->length);
+			trb_dma = priv_ep->aligned_dma_addr;
+		} else {
+			return -ENOMEM;
+		}
+	}
+
+	trb = priv_ep->trb_pool + priv_ep->enqueue;
+	priv_req->trb = trb;
+	priv_req->start_trb = priv_ep->enqueue;
+
+	//prepare ring
+	if ((priv_ep->enqueue + num_trb)  >= (TRBS_PER_SEGMENT - 1)) {
+		/*updating C bt in  Link TRB before starting DMA*/
+		struct cdns3_trb *link_trb = priv_ep->trb_pool +
+					     (TRBS_PER_SEGMENT - 1);
+		link_trb->control = ((priv_ep->pcs) ? TRB_CYCLE : 0) |
+				    TRB_TYPE(TRB_LINK) | TRB_CHAIN |
+				    TRB_TOGGLE;
+	}
+
+	first_pcs = priv_ep->pcs ? TRB_CYCLE : 0;
+
+	do {
+	/* fill TRB */
+		trb->buffer = TRB_BUFFER(request->num_sgs == 0
+				? trb_dma : request->sg[sg_iter].dma_address);
+
+		trb->length = TRB_BURST_LEN(16) |
+		    TRB_LEN(request->num_sgs == 0 ?
+				request->length : request->sg[sg_iter].length);
+
+		trb->control = TRB_TYPE(TRB_NORMAL);
+		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
+
+		/*
+		 * first trb should be prepared as last to avoid processing
+		 *  transfer to early
+		 */
+		if (sg_iter == request->num_sgs && sg_iter != 0)
+			trb->control |= pcs | TRB_IOC | TRB_ISP;
+		else if (sg_iter != 0)
+			trb->control |= pcs;
+
+		++sg_iter;
+		++trb;
+		cdns3_ep_inc_enq(priv_ep);
+	} while (sg_iter < request->num_sgs);
+
+	trb = priv_req->trb;
+
+	/* give the TD to the consumer*/
+	if (sg_iter == 1)
+		trb->control |= first_pcs | TRB_IOC | TRB_ISP;
+	else
+		trb->control |= first_pcs;
+
+	priv_req->on_ring = 1;
+arm:
+	/* arm transfer on selected endpoint */
+	cdns3_select_ep(priv_ep->cdns3_dev, address);
+
+	/*
+	 * For DMULT mode we can set address to transfer ring only once after
+	 * enabling endpoint.
+	 */
+	if (priv_ep->flags & EP_UPDATE_EP_TRBADDR) {
+		writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma),
+		       &priv_dev->regs->ep_traddr);
+		priv_ep->flags &= ~EP_UPDATE_EP_TRBADDR;
+	}
+
+	if (priv_dev->hw_configured_flag) {
+		/*clearing TRBERR before seting DRDY*/
+		writel(EP_STS_TRBERR, &priv_dev->regs->ep_sts);
+		/* memory barrier*/
+		wmb();
+		dev_dbg(&priv_dev->dev, "//Ding Dong %s ep_trbaddr %08x\n",
+			priv_ep->name, readl(&priv_dev->regs->ep_traddr));
+		writel(EP_CMD_DRDY, &priv_dev->regs->ep_cmd);
+	}
+
 	return 0;
 }
 
+static bool cdns3_request_handled(struct cdns3_endpoint *priv_ep,
+				  struct cdns3_request *ss_request)
+{
+	int current_index;
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_trb *trb = ss_request->trb;
+
+	cdns3_select_ep(priv_dev, priv_ep->endpoint.desc->bEndpointAddress);
+	current_index = (readl(&priv_dev->regs->ep_traddr) -
+			 priv_ep->trb_pool_dma) / TRB_SIZE;
+
+	trb = &priv_ep->trb_pool[ss_request->start_trb];
+
+	if ((trb->control  & TRB_CYCLE) != priv_ep->ccs)
+		return false;
+
+	/**
+	 * case where ep_traddr point to last trb in ring (link trb)
+	 * and dequeue pointer already has been changed to first trb
+	 */
+	if ((current_index == (TRBS_PER_SEGMENT - 1)) && !priv_ep->dequeue)
+		return false;
+
+	if (ss_request->start_trb != current_index)
+		return true;
+
+	return false;
+}
+
 static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 				     struct cdns3_endpoint *priv_ep)
 {
-	//TODO: Implements this function.
+	struct usb_request *request, *request_temp;
+	struct cdns3_request *priv_req;
+	struct cdns3_trb *trb;
+
+	list_for_each_entry_safe(request, request_temp,
+				 &priv_ep->request_list, list) {
+		priv_req = to_cdns3_request(request);
+
+		if (!cdns3_request_handled(priv_ep, priv_req))
+			return;
+
+		if (request->dma % ADDR_MODULO_8 &&
+		    priv_ep->dir == USB_DIR_OUT)
+			memcpy(request->buf, priv_ep->aligned_buff,
+			       request->length);
+
+		trb = priv_ep->trb_pool + priv_ep->dequeue;
+
+		if (trb != priv_req->trb)
+			dev_warn(&priv_dev->dev, "request_trb=0x%p, queue_trb=0x%p\n",
+				 priv_req->trb, trb);
+
+		request->actual = TRB_LEN(le32_to_cpu(trb->length));
+
+		priv_ep->free_trbs++;
+		cdns3_ep_inc_deq(priv_ep);
+
+		priv_ep->flags |= EP_PENDING_REQUEST;
+
+		cdns3_gadget_giveback(priv_ep, priv_req, 0);
+	}
 }
 
 /**
-- 
2.17.1

