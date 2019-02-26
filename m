Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF79217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bCLhj735";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EsD3p+Fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfBZRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:34:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48428 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfBZReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:34:50 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QHX0iU014356;
        Tue, 26 Feb 2019 09:34:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zgspVyXV9OmmjJdTe5ghc0+8GfXXO6DZDqTAkAhuXLA=;
 b=bCLhj7355+6NVYE1fzuCcXe2MALIdBIqIyAXFbikpmrlDPo2X6zsvhJgrNKm8FudRBzE
 clJpPacyJ7GcBJY1gaOQQc8u7wt5n4q+401cpg7sSIYPamE3XbMaNIvTYY7WUSgnoIZM
 RwWugY00Hw48lFgiUvBvGQpchhVbe8+CCyo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qw7e00rfx-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Feb 2019 09:34:27 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 26 Feb 2019 09:34:00 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 26 Feb 2019 09:34:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgspVyXV9OmmjJdTe5ghc0+8GfXXO6DZDqTAkAhuXLA=;
 b=EsD3p+Fl3zai8uU30sFZpzWtbw8hitErb5dOhMyUW0sPv5w4MhKKFw7jbVlX16+7vX27hkkX5BBp6HXoZya4iiwsdXGfx0Tk2pBnb+xKu1k4mK7OGShKIPpn+z3E7ecZXHZxhMHUkoGAP1UI/tlR9xRfl5rYm7qgYnjtGZSLCCY=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1245.namprd15.prod.outlook.com (10.175.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 17:33:58 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2%12]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:33:58 +0000
From:   Martin Lau <kafai@fb.com>
To:     zerons <sironhide0null@gmail.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
Thread-Topic: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
Thread-Index: AQHUzd3KjJLq1K7Rq0CzDeaiSl5dPqXyVymA
Date:   Tue, 26 Feb 2019 17:33:58 +0000
Message-ID: <20190226173355.chm6gwvwyer57yco@kafai-mbp.dhcp.thefacebook.com>
References: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
In-Reply-To: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:406f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23252ffe-8c4e-4c99-1893-08d69c109660
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1245;
x-ms-traffictypediagnostic: MWHPR15MB1245:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1245;20:4FgjTAymnC1VstydjuR+Uiw4LXKmdUrpSH08qDATQZNRvfC+ax6CTOlfvUbEmYl+JL6B1UuOs64wgwivW0p0U+DNXJKy6tzTWBKrNobUDvIEcCK/piZYF0Ntau4moJ1B4ePGGPuASldLSIFgBRpYSpz47I+TN4eyh5GdzWoM7HI=
x-microsoft-antispam-prvs: <MWHPR15MB1245111E99C3E572044F9710D57B0@MWHPR15MB1245.namprd15.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(51914003)(199004)(256004)(14454004)(229853002)(99286004)(71190400001)(71200400001)(106356001)(86362001)(105586002)(1411001)(6506007)(6486002)(386003)(1076003)(2906002)(6436002)(76176011)(102836004)(7736002)(25786009)(52116002)(305945005)(9686003)(6512007)(6246003)(186003)(6116002)(4744005)(81166006)(476003)(11346002)(8676002)(81156014)(446003)(53936002)(46003)(68736007)(478600001)(8936002)(6916009)(4326008)(54906003)(97736004)(5660300002)(316002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1245;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9CtZvayAHKoRx95nvoXSEmT2m1RL7y0ocoOqF/6d0Rd2cjPxv/UUy/xEaItsxuHrsPf5RT1PxDwvd+wxqpFzxZGyZB2m1PCwqydcQUj5eff1PuqpjzC3DSmM/7pdJJ9ohzeKO1XOWXgRKDhiHQJ8sxpTX25vUwVwEwX06xVptV+MhBYgcukSrGAugdHpkHN97orAXFRLfZw81pT75FvyKHAPDCInA7kM8fsU1v396f7HFDoHI1b7IzPXwAePjfxruV6lp1uO0GyIm1sRERPJwvngtJusphkYZ66TZ34T8fYVNQm3Gyk156VALaTKEBlkdu52f1DsFDJjMeWKsO0Fylxb3AM5jFbomdz7QbuFhDIT+jwLs3e9nZQwNSw/+EiWNLWskXB+QLYz5z7SiG9CKn34Y/Un5lTDlJLdR6TnAFA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48943E76A5B1CD48BC92A53BA2C83EB7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23252ffe-8c4e-4c99-1893-08d69c109660
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:33:57.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:15:37PM +0800, zerons wrote:
> [ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]
>=20
> In bpf/syscall.c, bpf_map_get_fd_by_id() use bpf_map_inc_not_zero() to in=
crease
> the refcount, both map->refcnt and map->usercnt. Then, if bpf_map_new_fd(=
) fails,
> should handle map->usercnt too.
Good catch!  Thanks for the fix.

Fixes: bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID")
Acked-by: Martin KaFai Lau <kafai@fb.com>
