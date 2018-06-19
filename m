Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2257FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4E02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LDbR/5br";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jm1C2fFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4E02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030733AbeFST4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:56:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030472AbeFSTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:55:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JJtTP6030573;
        Tue, 19 Jun 2018 12:55:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=5ismp5RNMkW12oWlGaLYK/WMhlNbSpd78Lqr5jY/oL0=;
 b=LDbR/5brEplV4jIUBsbgi1C3m0eGgr3PZDgfr87QTojWW2WWHurfIwb+2Ji1S8d0VXLz
 CsGTKPgkIpa9b2WEY/n7EnwUrGk1CfPV3Cr4SQA2Kuypfz6wyM1TVlnqA6AGngcV4ebo
 clB2FdFkAjuZxZRpMs3b5ZCB0wmpXqQcHkI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jq7ukg2q2-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Jun 2018 12:55:39 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 19 Jun 2018 12:55:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ismp5RNMkW12oWlGaLYK/WMhlNbSpd78Lqr5jY/oL0=;
 b=jm1C2fFsMkKvUHbxJQm+Rq81Eth0fJi2zerBDzEz57Sc8TLS+SRBx5TfVW36LPMkx+KLAkrElauYNgRS9z9BY2dzMUDje8FKLW+SD44UULDVRVIByBvhpacYhZdx922dLJ4bPzdRbuW8MvcdR5LKLZ7miRsnGlGYmHTum2MdHyU=
Received: from castle (2620:10d:c090:380::2:787b) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 19:55:33 +0000
Date:   Tue, 19 Jun 2018 12:55:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/3] fs, mm: account buffer_head to kmemcg
Message-ID: <20180619195525.GA19193@castle>
References: <20180619051327.149716-1-shakeelb@google.com>
 <20180619051327.149716-4-shakeelb@google.com>
 <20180619162741.GC27423@cmpxchg.org>
 <20180619174040.GA4304@castle.DHCP.thefacebook.com>
 <CALvZod5_0_LuqWpri=uviE5hHhTMPT0VQOZDgHtTtLhvcCtb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5_0_LuqWpri=uviE5hHhTMPT0VQOZDgHtTtLhvcCtb3A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:380::2:787b]
X-ClientProxiedBy: MWHPR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:301:39::20) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b467804d-55dd-4c20-0fba-08d5d61e9f3a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:FtliEfvNyGn0FlxGIONJ5hLMXKqinNipxT09bLq6tG+aLt3MfbTyK4BVGxzzm1XZLcDb0H+fWoHen4hgS9kZoG1kmmXxZPMRgyuUTa6IZqW81O8FGxvgLtWH+QgARgF3+AZhLCCZcfNUQoPC11FgrTASehuyyyURaWHUaP8dxU1Qn4liOooBvpkiRDKCWO4axaklUZ7EjTE02ovb+W6E1qu0k3V2MMuTzH27SP5ESu64a8j9j+09vzayGSweU4kX;25:Szm3en0VPJtuVtfJ06LTXB6i9qSvgAyIkw7jeNeFUUGOUHL3xMxN/wl2lDQTe246rybyFFm2C5TaGK0ooa3N36gDZ/yU5aNNz0ztSj+yn2mgH7fEe2hAp14vAP2JDknsayFRA0v2otOPY9AX2FsMeefI0LhkW1UP2CKZoKUg0sSQk/DFrY0OsA2PcGTe+ayCn7eWAfIR8MROsnrkm/7IviAy0PV9w8LHd3AvDQiMXYMYB4TvduwB812xh6/Q/SzFGtxzn/athmYe4A8I8RktWjxxprcc0IT7RHu/wPVV4rjKG7axCrKdp4NUVol8hOHqSa8TeBDp/XZ0ibwM1GgZXA==;31:HEofTRRIW1AgJQXsyg6OZD4gq31jw2wto1VOQhUQLxrNSmaAO0qLQKduvMN9LcnB+fnLY4QwTsn2TGXL8TYR8trHjkuOtpsQQVbJrw6o4V+sV/Jmx+/USLrchp5f+KKzqoiCHcPqBvC6c7Ok5etNrcZqgnlbJiqyAgI8xfcz0kZ/cWaQlbr4NwD6N0rABEDpsyEyx9wf+mIxNfpOhAmNH4VYY2VSjfpGZKR9zy+17yg=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:6FSmgUxappDQwfAJup8V0m4DVuJH42kiyktZ/nXQvCn1kCKw2CmNcba+y5gELOfRts4zkqJ1PKXnxEAhJbee/plmWyWzlLiItsZQpCfyRC1QcV8CVFEzCK+tZa+wKItZqmtV+ImHwgJ47Ym0jGtLNDrJsuZCGA6g3MXeeFMWqzmsp+Ck5PFUajhowIuMjKBdSQY29DlvloIWMa1kZ0fK95IR30bEzubhL2qHeTsP1x4BPnCxsREdUo8ghvJ5fgaX2RTPDwgYq3SaRKRAZLWnG01I5EZ7Gt2kpJdvhHqq97yHZZDeVmqfXUqutCsbfqdjzwBqOOXtAx9dwIWsR0+twYcB3Ghmd7zB8Iy9LLs75c8DpjfvSSelMCgtMTRUF8dyUlKiCyGkADMKmgsbb/QDtK6g4aiVv7RXrxlgScb6xVCic3lGc86XsR1guVvMSeBQHAE4Zq+h9pk7WEuRif2vCiAZ8YtvhLzLCEbhfebm6zrLJocABh94CMBTwnZ644vp
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081E8DA43F297CA0F59B7F0BE700@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;4:kTlGWyo7VfDgnApi5O14jnCSoo27Mg/PP91cHLsGUEF4DTkOCWGgeNOV4/ShRn6NYG1vBJ3uUjKrsUsUS+418E24us8RB8FgdArtIi88+/SS5YYaf+RwVcjv19wziV87RpIhaFCU5uWm668Xikn+vocPj2N0XZWilMb9KH6M9GZIIA6U1XvtPfyogCVM6aNXL4IF8s5unH3bK9LLb9/FFijLc3YQ1G5kZ3ggaQar+J/AdqrHmjz15Bq1vHvwNK98xTWsEPWhpg/mG9xY5yvDUEmSYG5e6PGIzUFYcXGbN5B4hD8K/xdr6UlgoMVKCzejjZrZfebpSNsQ4a1Mk+EyJ65fBppd577ub5KAXpq81bHpXaSO8eW85V9kyPcW5goQs0sdrnMcojzmCeQXWfvBIz32V7sjc1Uh6Pz3ivsG/FPxvFSbYsskMFdHE7v8cv5Cu3ghA3OxJtR5uEtNjhQDdA==
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39380400002)(346002)(39860400002)(189003)(199004)(93886005)(54906003)(5660300001)(23726003)(33716001)(47776003)(316002)(476003)(39060400002)(1076002)(16586007)(16526019)(229853002)(186003)(6916009)(6116002)(46003)(58126008)(7736002)(7416002)(6666003)(55016002)(305945005)(68736007)(86362001)(9686003)(33656002)(52396003)(478600001)(52116002)(486006)(106356001)(11346002)(25786009)(8936002)(50466002)(386003)(53546011)(59450400001)(53936002)(81156014)(6496006)(81166006)(2906002)(97736004)(33896004)(76176011)(105586002)(8676002)(446003)(4326008)(6246003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:OVArNx4f03s6C3XHPTpn/84zslAZLKF2FOlOKc9uT?=
 =?us-ascii?Q?eOiERx7GY11ktzRM/UNfWCInyTX8maicv1ftiH8dm4w8VuiMRXUCSvuv0ZQf?=
 =?us-ascii?Q?cL7Dgo+w8YN10orHiRH83H7L9eWhWdlhkOZKJgcUM5qUqxBc26uhcdDzomNe?=
 =?us-ascii?Q?MkpYJfpiHYREiJdywz6YRfO94JK77sJpvn4NK1znHmuUiofVcFtdiJCShypc?=
 =?us-ascii?Q?KiCN/qhKbCt72q0NLhMsqZhmxIQCbo7eDpB9qi6E2ygBLnhxGInRjFCOliz1?=
 =?us-ascii?Q?jmclz4algXzoRAWcUvAz+DZUGgJe7wrEET3QHNeWTbZ008R6s7UXQnWkMzGn?=
 =?us-ascii?Q?OGH01rcHurBOpqfz6XKmVStACgYu3Bc4rtC4LCJIMIeVyviegsy5+H8oGXb5?=
 =?us-ascii?Q?Sru4hvNiukt++eBU1PIXaeF441L7sjk3TOx0mCpRfFm4rl9VX3rOFkDuzRse?=
 =?us-ascii?Q?C+rZu0BDNXVRfG/jwtT9nVgDou+c3tNTkKzKsX6FQZZPAj1HxmHPYRAQ8Lmk?=
 =?us-ascii?Q?zMJkq65aonh0D/S4vxBH3vCEZJ/2ZNfgSDowNvxNlCIJ+avE0DvNSmrIj6s5?=
 =?us-ascii?Q?Ruv2mHEcI4eP9uPBroq3YpuG3r7h4zoy1grKcbZG9HHr6n8mOd12D6AW0tkl?=
 =?us-ascii?Q?EE5nr0oDdwp+gnM+WCEsECQ1+zlmY1+Q9E6LI4UWNnS3Hu/ccIZJq6JNdu34?=
 =?us-ascii?Q?Sf15CTk9sNEONfF3tMBF0hIcNyRLXSHMHy8baleXs6L5G4VQg+n5qz9/ZRAm?=
 =?us-ascii?Q?qt27mjCN7PNWoFgrs36Ge9p1RlVrRrbSwCkmn5o0E/HIhRYpcCQixv7RnSgo?=
 =?us-ascii?Q?7COXST3Mj1yRrDXsd4LcVT8jOgitnU+rT9Y83WgIdjtI5iO/bL7+yO1zP1fi?=
 =?us-ascii?Q?Xbb4hMyp78J6cakGT8QuI1GylLYSMr3QZIHazakQx2Y/PUeDcV8wNFAWsuS9?=
 =?us-ascii?Q?WJMppqbmK1XVosU/VVuJcpkYvaMlw5HGd8IHtZ/nCuc45+rhT/jHMBd2DPpF?=
 =?us-ascii?Q?8Pva8p43+tyJHzcClmUAscpKWHnFB0iAxx/4OHMji6Z4cfIuFYGD77jijwwD?=
 =?us-ascii?Q?ki6CqG8UAuIMgxcsEwZnkUYyW8WiTKhPMILKpWzmIiucThhKq5KDF6Ln9WWh?=
 =?us-ascii?Q?XWvxLKcjr11yDWNH6swB/hSqlgjuGEXG3xG0OvzrDbPEf+FFufGRIKqalaGI?=
 =?us-ascii?Q?DABgIU3E1jz5dJeARdZI7+1zx92lnr/Ex/Xms7tSJyO5N0JgexXTFCs2HoM6?=
 =?us-ascii?Q?uqxlAKQe9MFed4ig9s74zGUqS8t/ASC7NU9nLh8zVdNvGIxxLHXaO/utRaPG?=
 =?us-ascii?Q?FLYrpr+CP5O5ExdtvgkMy91TE+TviyJa63UUXWsdXIuqY1E7yZuJtHYxqINs?=
 =?us-ascii?Q?/H/MCMAvKGnUw3wmX7yI0hjA+93UyjHaJoO+X/OpJNbVONX?=
X-Microsoft-Antispam-Message-Info: z3rzbYiyrQzNd0OEZd8QmAnMmgVwMQH4b8Qi5wevbcCI/CK97D7Oo9r1y7ZJFg1nyBmleu1N3MAUc1DOqwIy4mgetNRlHbPbxu5YxuQ+65bwhx6wzgMYkWP+Gu/EgvrH7l+SYI4bD80RKzeNG4bIXgQgBKz7FA7p2X5WMohxIc/PLwqfwZmjeZ2D0pSFu3SB+Izo8s6p0TckZhVZbQ8epNElpMq3lFaXu12rxuP85DkfMKw7a+l3E/1rdkTHPapiY/X552Xm5O8j1HLOn/CJM+Xuj4JlU++Wqcs4tfYSGQEOh8XaE2hH6pY3r715TZjZ
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:aON2ZIp6RNVACjn+jJ4xGMcp+5HxnliABGLWBH/Vvlss+1jEwDvFJ4wXtXVUTbham3cO4GiQzrbYIt+gZ39nkzZ3qN6ZkVCQs1GMXQcAUxI37m7jh9oUfgbMtjEjbeOOEyc+wFgwIj00DjjMRuUiTLbOqIds6kAxqi0lnkxU5OC0UKfiBc1mJ0AKRhawD2gumM9ja/wKkSqS4QUBGZarPV/ex4JFArSPBTGHUVaEW80zAJgoxh+6ThYnW87cXhviE6jBpVm4Nvi/C/qC27KIimgMB1kg+WxpSwye4+LZ+Vrf0XZBiAdA+E5DHhD0mJbdabhkFm8jMJRywAk+/Cs4mhFdjiorxBeFBPU3pHF+QcggNLU9cgSjOYFQ31+a1h+O7X7kcwUqOK7zO+iHInn7t3TC2X2PrZzWbXjoU4lF0nQmmZ+Eoy4WclVYqRit+uOBR2l+N4C9/igiXc+EBFT9ZA==;5:j08uIMtQmklohR2/OOYHO0Cr/GdWwMmECpVHnMAW25oQ07GR/aogJA3CfDxzCbmF7fcXtsmDIce1QDuUEKbOCLH9rLh8qNUfVmknmFps0IhChu2RL6V4H5l6F89SopUD6qiD49554EgBc/RZdD+S8U6VayI5e/mzSElR80GE2cc=;24:C7BUlck1G089/5EHCAEgoYqSIXMrkj/K66hIedQt/bEeirV49lOgTCCyfBfOJboN6tL0yNo+PJAQcVXDIf/tk14Xrcj1R+TMp2B+Gs9CJU4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:Zik28PP6f1rmHLiVVXlK+BiEYZTns4N1pFVGFRLuRUKjgyfwc5OoWwTLNKWZOo4wPbsc0B9uan8SVq8ZQJU15NY/muG0NSO852L4v/Fv53fEuH68tMPJZd8+iisn7k6jtL7I2oxczlU6zyOlg7nD4noc9okqpkS756hQRmAyBsaETaKEjgebmP5xbPw5gnOBka4sJypv+k8hATDxEOg3hb0OlnfdJ2ghsss+E3EFwdlkUctp69MxH6wIQTDIblBF;20:aRMOGjh6LV7wXKcl04LXZbYkYw09iRFHb2pwQGyPEJrvy6pAY17osZoEzJJ97zelHXuOldFWqijfK+BwjspZyjhAtDHp9id/BtJPwUKu4JZBlc/22C5Qi1z0FJyPgckXX96U8+iZskpvFmdIhbbPkQ7sB1pnJT4JWJytcbm8KHI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 19:55:33.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b467804d-55dd-4c20-0fba-08d5d61e9f3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:51:15PM -0700, Shakeel Butt wrote:
> On Tue, Jun 19, 2018 at 10:41 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Jun 19, 2018 at 12:27:41PM -0400, Johannes Weiner wrote:
> > > On Mon, Jun 18, 2018 at 10:13:27PM -0700, Shakeel Butt wrote:
> > > > The buffer_head can consume a significant amount of system memory and
> > > > is directly related to the amount of page cache. In our production
> > > > environment we have observed that a lot of machines are spending a
> > > > significant amount of memory as buffer_head and can not be left as
> > > > system memory overhead.
> > > >
> > > > Charging buffer_head is not as simple as adding __GFP_ACCOUNT to the
> > > > allocation. The buffer_heads can be allocated in a memcg different from
> > > > the memcg of the page for which buffer_heads are being allocated. One
> > > > concrete example is memory reclaim. The reclaim can trigger I/O of pages
> > > > of any memcg on the system. So, the right way to charge buffer_head is
> > > > to extract the memcg from the page for which buffer_heads are being
> > > > allocated and then use targeted memcg charging API.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Greg Thelen <gthelen@google.com>
> > > > Cc: Michal Hocko <mhocko@kernel.org>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >  fs/buffer.c                | 14 +++++++++++++-
> > > >  include/linux/memcontrol.h |  7 +++++++
> > > >  mm/memcontrol.c            | 21 +++++++++++++++++++++
> > > >  3 files changed, 41 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > > index 8194e3049fc5..26389b7a3cab 100644
> > > > --- a/fs/buffer.c
> > > > +++ b/fs/buffer.c
> > > > @@ -815,10 +815,17 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> > > >     struct buffer_head *bh, *head;
> > > >     gfp_t gfp = GFP_NOFS;
> > > >     long offset;
> > > > +   struct mem_cgroup *old_memcg;
> > > > +   struct mem_cgroup *memcg = get_mem_cgroup_from_page(page);
> > > >
> > > >     if (retry)
> > > >             gfp |= __GFP_NOFAIL;
> > > >
> > > > +   if (memcg) {
> > > > +           gfp |= __GFP_ACCOUNT;
> > > > +           old_memcg = memalloc_memcg_save(memcg);
> > > > +   }
> > >
> > > Please move the get_mem_cgroup_from_page() call out of the
> > > declarations and down to right before the if (memcg) branch.
> > >
> > > >     head = NULL;
> > > >     offset = PAGE_SIZE;
> > > >     while ((offset -= size) >= 0) {
> > > > @@ -835,6 +842,11 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> > > >             /* Link the buffer to its page */
> > > >             set_bh_page(bh, page, offset);
> > > >     }
> > > > +out:
> > > > +   if (memcg) {
> > > > +           memalloc_memcg_restore(old_memcg);
> > > > +#ifdef CONFIG_MEMCG
> > > > +           css_put(&memcg->css);
> > > > +#endif
> > >
> > > Please add a put_mem_cgroup() ;)
> >
> > I've added such helper by commit 8a34a8b7fd62 ("mm, oom: cgroup-aware OOM killer").
> > It's in the mm tree.
> >
> 
> I was using mem_cgroup_put() defined by Roman's patch but there were a
> lot of build failure reports where someone was taking this series
> without Roman's series or applying the series out of order. Andrew
> asked me to keep it like this and then he will convert these callsites
> into mem_cgroup_put() after making making sure Roman's series is
> applied in mm tree. I will recheck with him, how he wants to handle it
> now.

I can also split the introduction of mem_cgroup_put() into a separate commit,
as it seems to be usable not only by the cgroup oom stuff.
Please, let me know, if it's a preferred way to go.

Thanks!
