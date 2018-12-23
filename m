Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8557C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CE321975
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZlugM6e/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AkMsRVOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeLWPOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:14:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34402 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729032AbeLWPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:14:36 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBNFBKNs030275;
        Sun, 23 Dec 2018 07:14:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ZF9w/wUK8Jdw3iqjgDRRmEbDVCTbK9xnRELZnBVq+vY=;
 b=ZlugM6e/HcilM44cC5ICucv9CEJwCZULuDBuHEwpsu4At9iFfx0M249h2EYwFiRMJkzj
 7a9pxgQc+HZbASVDk36jMwoMLVNqwLiI9MScV9cecopiia57UuNWOdQWuadjeVxJYEec
 KZayUFW8sQgDuHE3tKVycqJLC/6JOKpqHPF+2QLD0gvQCQk4s2O6L4JIFK5wq76VTQcI
 7RLwrqKBHLxnBYbpMD+yNRwImw7DbkogEl7CGEyT+2LA5NgeXmRAd5zQIJXBkGsU26Kf
 L1iKWYZ+ACl1yqf8OyfBznDBQK4FL+p6mqpufpDFOGV+fHM2PBNR1lpIfVO6D7gNpK8k Ig== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2phjq1n5cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 07:14:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF9w/wUK8Jdw3iqjgDRRmEbDVCTbK9xnRELZnBVq+vY=;
 b=AkMsRVOxcW2BvAWhZYowNNOVwJm4GgakGjjHmchJH/lwaSB3U1/EBYbwkWgVXprg2BHyTO99YEG6FN0qWHuBmGCws2LLpv9MMWfMICVZZHkeo0OInEZ8BG05b8g4Dwq5UW91Q/oV/0T7rP0SkMSymJ0Vf5Y22ZE1QjV0rQVVYSc=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 BN4PR07MB2162.namprd07.prod.outlook.com (2a01:111:e400:59c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.17; Sun, 23 Dec
 2018 15:14:17 +0000
Received: from DM3NAM05FT032.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.21 via Frontend
 Transport; Sun, 23 Dec 2018 15:14:16 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT032.mail.protection.outlook.com (10.152.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.7 via Frontend Transport; Sun, 23 Dec 2018 15:14:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBNFE6Hb004426
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 23 Dec 2018 10:14:07 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 23 Dec 2018 16:14:06 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 16:14:06 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wBNFE4HD007101;
        Sun, 23 Dec 2018 15:14:04 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wBNFE1Ka006935;
        Sun, 23 Dec 2018 15:14:01 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 0/5] Introduced new Cadence USBSS DRD Driver.
Date:   Sun, 23 Dec 2018 15:13:07 +0000
Message-ID: <1545577992-4013-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(36092001)(486006)(81156014)(7416002)(316002)(81166006)(4326008)(336012)(476003)(126002)(107886003)(105596002)(14444005)(47776003)(356004)(305945005)(50466002)(48376002)(97736004)(39060400002)(106466001)(8936002)(2616005)(426003)(51416003)(53936002)(2351001)(50226002)(2906002)(86362001)(217873002)(68736007)(42186006)(26005)(16586007)(87636003)(478600001)(26826003)(54906003)(186003)(5660300001)(6916009)(8676002)(4720700003)(36756003)(6346003)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2162;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT032;1:NVePq+2XHMIIDgaaImOyoADWhT22eAkdBU35ZIVX3ITm3LNYVAX6qTGrHLtHC1WPYK+WeqVsZy5oA3kJpY7S8ZnR+rRWg0uPFgtnvxkC/VGupH2mh83ChlcLFFIYqLXQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf6f4454-dc21-47c8-f88f-08d668e94dc8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600098)(711020)(2017052603328)(7153060);SRVR:BN4PR07MB2162;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2162;3:Sf4goZ8NkTmB1daU4zWUYawQvNmWMLYcMDO/jAoRTXbRp8HCjF38OGKePIVh9W6GXwj3sk6CWqUpAS1dT4FByeoFKxAcg4JNTyN80DHJKMt24BGjwQmUq0Jepv0UkKEdYOddObYYiKJnx3UraL3TQi84LIdQjEj2ZEK7IAT1RZ0eGJ0Q8zBqZ2BXYyXIi5c2brJw54eFu4fg8qytEM+GgjM3KTpqhJVtANKtxgJXxxt5i8cyhmmfOpDMVIbaj7iUFlBWkTU/ms35oHBc4+2Q+cHp7zcZG/xZBG2ctg1e3QzwO54kRd7Fbi5MGnCI0t0A32o1FjZPxMxbtWhCivQsGg==;25:23RevmTXFy6VaJKaYWJwP97+ftGSC2on198MklZ5f1sdxnEyP09mPrEQh70bzxte5bkrJEMpVJU1hsvbhXjBDHgMCah4HoRKTLEiN0w8jmqRA0jF+dNIZmtuDj1TzNZIxRxShZF/DSjku54HLn4VMlqIwKVDXP72xL8J9R0ze91vSRllTXxdQf+fJO30pBUOUQ0z7wSz+9mLRXewOA+bsiSVqwdXoOc85vdZwTByvlOkGMlnpCwvPGhwGrQPa6tZQPwCnw8vlcqSeuNOO8eqjwWrEn0psL8lc6rvbiLffYEDFW+w+ouMId1TLsKkPTwJ0fkEfOShcELOFAQP+Z/CwGWjcca8bnZJ2FvDL3Elvdo=
X-MS-TrafficTypeDiagnostic: BN4PR07MB2162:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2162;31:Kg1jWro3tFLhFO8X3PUs8ro2h/CvXenSCvOgV3Y3BCOHj39BU8nKZoskmpEH6QK1wj6jQZoKQs0tEr0td+9XZhVol33g4TRakGWIgXrjnzZFmhEAzcVPOC8aBiSentRKAMgPafYF2r2EtV2MOlfEEu1CK2KJC4WARgmu1DQfOqlQ5yg9NqeGA5p7mcLpD3onwLieG5PW0wcA+0w/ovrnzIinNR5uBba/aYUNKPPSVMw=;20:x/WgK+/4PoRrRkqzdYfvjieQQmla6giam7+ApZIXk0aADJPMNPBkFj3nlzw3e8Rvga82vmtwAYZWy6DPtQGqRx5PisI2nfyJvTp6ClSXB+7DzngjYMoXoEc/N+RUxw78lHoXCWIrFTh0Nui/ZtfzQnJYpi0rv1z6PP/LMzM9IoiAy3dEHAV/T4ppW74MbIUceL+6HvDPZtxS5On1jFs9nW3zHOAOKXJEY74KHXc8xpHjJHuHH1CI7B6aALUwR+8g3NUksVJ/OcWpvOgToHg1pmUfLRYBGTnHqTLAVYgN1Hadmm562liiIWFp4Es5nOL1igADuHhc9VbqNXDa9bBYq1vKZTdx2quP91JlsfS6srwRVI6IRQyef/txqiw0EYuNOx/LW1mtcCCJSBfgmYH7Zy0+y/+1arIPH2E+sl8HlyB6pF1BzQD2OLVUhvL6cJUGB+ME3y78CTqStpiruVOlFBWS8a4q1iHLZ6bLnbt4NEshVim/mV8B40iZonwSnSXo
X-Microsoft-Antispam-PRVS: <BN4PR07MB21626310BC0788A828B9EDA9DDBA0@BN4PR07MB2162.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(10201501046)(93006095)(93003095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN4PR07MB2162;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2162;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2162;4:IAFHtnGugy5Gw7d5vaTwizCx7XllXkJit4uYb4sgZVFD4Nlpgm5odUkc7x55iouekfCfw9LpXdWNkTXSgzNKX9cZGCILb6fUFijeLHD+u04/dMiFR5r3PI3Qc6ZaHPaq+0qYT/kRFAoR+buULLf77EZEadIwZcGcyqBPmQG88A6blkdnUTV2/hh8R+D5QdZWxyWsizswCZP2EsKiGY19ssHtJczBfPbnRTbUcTVZ8HhWEh/bqrOxKiDmGWz6ZYIpxpo578mM6bShGGrZucUhyA==
X-Forefront-PRVS: 0895DF8FFD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR07MB2162;23:hPPwkcL/AQD2kIuSdroIo1xfueiPQX9iMkEYvJvjG?=
 =?us-ascii?Q?XGLC2Yq6BAqY7hhq/XdQ1KOivhfAi+93iVRO8xqZabeb5jjnO9Q5iMk8sDtm?=
 =?us-ascii?Q?EUFEyohIDeWH/YPh8SxHgHqlnxvoDlhD3xaZdqTk4vxdTHYy1SqqcdSwpTt+?=
 =?us-ascii?Q?jF385mKFf/t0OatzA+Wex78X+uxyTQTQfS0YNs+CYduvOyEPpcfUoyIAyLRi?=
 =?us-ascii?Q?//Ir+LNwb3bMHsbXY7Iwe7Ca1EiBj6e9Zhiy7rOR+wToepsbLxMyzXOmHwXN?=
 =?us-ascii?Q?nNXAoN4Wzq+7FWb42h029Ziwfa3Wbl75gYKboG2sGvW7kwwKrvKjt0l/Gv/2?=
 =?us-ascii?Q?eU7zH44xOhU84QHl6so97V0Tr0Lk87h3W5U0NjEYMFEtPAs86SoOwxl0gCd3?=
 =?us-ascii?Q?JUXxVthKn5Ns/Bdb/S6KvUhnU64Evk4Xl1Le+eSXaDgynC5AU7XWwDNtqsjH?=
 =?us-ascii?Q?1mJTJG0wZDyKSI1lR0B60zWS4G9pGExh8SggmLUeaMt+ZWFuiQT1FH96Bf2J?=
 =?us-ascii?Q?Ajrhh3YJwF37WpLFRNHjJD27nELZR8tcUgMM8/21+iNrTfHLMGMoMt4xtAen?=
 =?us-ascii?Q?jBOPxjgjQ8R/nVQqmNaO93U8ecqVihabPSW5fRJ3rJnYY5K5Sup0Esm1O2fe?=
 =?us-ascii?Q?pHQjGfOLcFgNOvqq0wcDQhoUPUWYVEtCklE5B8/vbu8uqZiAd1s8VXNNhbCU?=
 =?us-ascii?Q?H8nnNIooW/T6sk1SwDZHCNgqZ8TG10OAM9kP2BjKn5coNgOh/A7/ze2dza/p?=
 =?us-ascii?Q?vyzRtAGn7y7E+x14LOJ9QWi+aBfO0Ifkq9mnmhZ77wXLpSB8DglO39+4faFk?=
 =?us-ascii?Q?sn2xofMEt733IDUKLpIyGfVhoaV6S7cjBsXvaftj59MrCceUWZO0eP9O0RJ/?=
 =?us-ascii?Q?hdhGPL/XCGlkt8/VstCP5ATmgWe6RmWAwe2OvI+H76mwpGyOjJlnkOL1h43S?=
 =?us-ascii?Q?cH+V7T7oAxYAFbloXnUMgFDPZYFs2herdxisMaIhYB4towDXQrr/ssv8QuHs?=
 =?us-ascii?Q?BKO1WvUnqaFt3Yaph3hnei5p4q0BdL9q92t8vEYM0ihfmd8B2kYqazzoC5nq?=
 =?us-ascii?Q?7l9dRbtViI4Uen91eRfFhYgYOevgTCDOOm45hpnmk8igonqY5ePcoWMJg+Pr?=
 =?us-ascii?Q?xK2FZ5r61ONYHPTyJSfWCyFmjjDSfGnMbYPiNG6lL2wVlTu56D+l3rtFD5wu?=
 =?us-ascii?Q?7Rz8YRiwHh8/p3AnOnVrlm2KlbR1zQTAChj4ByH6cxDSe9AbvwV7rIQETHth?=
 =?us-ascii?Q?6hCW/HP7mVqo5UDkAk=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 62GdLROMuTrhQ95OZhsR/N78c5TCxBXG2LTEXCgEW9ejEwGIoRM9KoIY30duGhhaGjhjRvluptLbSS51cRbDc7wUA8dXwFf3PmEGeSPoNOy2R9ua2P7Om+r2OAauWZNh37/4exn3njBvPk/rZmhlEXLsjSbyk5sSmgsJbYHTX91JAPI4ONFrJ81ODrpaWYxXxrVYSvxSXPDBp+B5PvTWYJy3F76tKpiezgdwF/1OHZXVgNZBOcvDKU1PXQ8EdigqK0u/UMAGWqdrAgaBg0RvnTpI6kmLDwL2W7QbAmu8Lp+M7ryc8ZX1vDp0oc/hJ2T1
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2162;6:lhasGp4M49vBQM3AJedqiOwIcQZG5fd2EgeWQTHzO/9iW2ROZOOh2HcT+dcUZXLMxSg2670KdGnc6vkYG4d0Q7EYH9/XsnT4JYmb4T9XpOp6AJj/JT2IfEZPy+PZ9ZPt+Z+LisHD2sOxc8fNUYHVF0KtJE8fRfprwpNNQ0/ydiz2vJLx9oLbmoDnpCAp9oDLRW0OK/MD+i0WujElMSUCvCaEah7hH88153NstaTxokgdepKePqBSwSdKcTfdOPIPhge01fNnkaRRN2YT263HfpKVzvqIX+o6RguGcwBSp0OlniZtVCEdTTBLPySbh2j9bfiS+w6BsLPFBFlKyI4gNtit3UBzbXNzbQnOPHWeXFUtSb3ZZYmUKFuwjC77ibqVoRQK0KZYeWG4aKkU0o/yz5zJogpxrL7BwlALwCv9DOpLmtKhljzHBLxsqxgG8XFCUmYzbR2zpxdGzxKBaG4/+w==;5:vZRxwl33U9QUKhBu0K23V5f+anyPQzizfQSqi6UEnm/YZCmBJIRtJm65k1ynqTxxEaoT1yRrVrDNNINoMTEX8fDBPIjUsfFTjLeEPgEFCrDzPqKbBvv6uHg4bEfeRjPfiYeOdWJXJeZbVdZMtUOUmGrCEi2L0B804OrjUiWA3r8=;7:A4Fp2XHJdr6xus3Yo+KBnIMIyrE1H1WoBFM4TYO5kYw9iNqi5kqXtSmBnXwmkLdr2fsjXaLGsQPGhls9E4ArkmzQX7VXQAAXgARp553QT82LA19vrIWKk7D2CCw1r1ZQhLB3L2T56uzlMxakueCxLA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2162;20:wzmjX0Z9bheP39mgxVlSgYxB0ehk7LWD1yj18CUzlDEobVJtOCQE8yNOPSgm+SHLJxgarQBK5Zqu1TuVS6XsCGKKuVkKfCTBEiwzAxl0Au5feYsAtB9aeOggr2jk/I64GCk2w2w3bH6NTsrW1CXGC/kcecUAUVQuJA4XlDFAPWT7soSOzXEIg/1V1q14PT3DovutnNvr5q0bHH2jp6Ikal0WV/iSMxMwN/yfBDI5w1MLecRhG+MoXSGlEMR/mX19
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2018 15:14:10.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6f4454-dc21-47c8-f88f-08d668e94dc8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2162
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSS DRD driver
to linux kernel.

The Cadence USBSS DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSS controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Changes since v1:
 - Removed not implemented Susped/Resume functions.
 - Fixed some issues in debugging related functions.
 - Added trace_cdns3_request_handled marker.
 - Added support for Isochronouse transfer. 
 - Added some additional descriptions.
 - Fixed compilation error in cdns3_gadget_ep_disable.
 - Added detection of device controller version at runtime.
 - Upgraded dt-binding documentation.
 - Deleted ENOSYS from phy initialization section. It should be also removed
   from generic PHY driver.
 - added ep0_stage flag used during enumeration process.
 - Fixed issue with TEST MODE.
 - Added one common function for finish control transfer.
 - Separated some decoding function from dwc3 driver to common library file,
   and removed equivalents function from debug.h file as suggested  by Felipe.
 - replaced function name cdns3_gadget_unconfig with cdns3_hw_reset_eps_config.
 - Improved algorithm fixing hardware issue related to blocking endpoints.
   This issue is related to on-chip shared FIFO buffers for OUT packets. 
   Problem was reported by Peter Chan.
 - Changed organization of endpoint array in cdns3_device object.  
      - added ep0 to common eps array
      - removed cdns3_free_trb_pool and cdns3_ep_addr_to_bit_pos macros.
      - removed ep0_trb_dma, ep0_trb fields from cdns3_device.
 - Removed ep0_request and ep_nums fields from cdns3_device.
 - Other minor changes according with Felipe suggestion.

---

Pawel Laszczak (5):
  dt-bindings: add binding for USBSS-DRD controller.
  usb:common Separated decoding functions from dwc3 driver.
  usb:common Patch simplify usb_decode_set_clear_feature function.
  usb:common Simplify usb_decode_get_set_descriptor function.
  usb:cdns3 Add Cadence USB3 DRD Driver

 .../devicetree/bindings/usb/cdns3-usb.txt     |   30 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |   16 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  157 ++
 drivers/usb/cdns3/core.c                      |  406 ++++
 drivers/usb/cdns3/core.h                      |  116 +
 drivers/usb/cdns3/debug.h                     |  166 ++
 drivers/usb/cdns3/debugfs.c                   |  168 ++
 drivers/usb/cdns3/drd.c                       |  350 +++
 drivers/usb/cdns3/drd.h                       |  162 ++
 drivers/usb/cdns3/ep0.c                       |  896 +++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 2102 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1206 ++++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   72 +
 drivers/usb/cdns3/trace.c                     |   11 +
 drivers/usb/cdns3/trace.h                     |  389 +++
 drivers/usb/common/Makefile                   |    2 +-
 drivers/usb/common/debug.c                    |  265 +++
 drivers/usb/dwc3/debug.h                      |  243 --
 drivers/usb/dwc3/trace.h                      |    2 +-
 include/linux/usb/ch9.h                       |   19 +
 25 files changed, 6637 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h
 create mode 100644 drivers/usb/common/debug.c

-- 
2.17.1

