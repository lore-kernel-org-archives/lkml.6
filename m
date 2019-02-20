Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8254E206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SfSFDyeX";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hvWMeHc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfBTLTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:19:35 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:59878 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbfBTLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:19:35 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KBFc9j031795;
        Wed, 20 Feb 2019 03:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=jzhUcwtZ0TjYifcBprq7tjcJRfKrXmOYgcnsNxuJBo8=;
 b=SfSFDyeXQCbTdO0scWhbz9fJrr5apRL6OdIaUWFr7wGJTmL0s4DsnkhyqfiuuHp6GqiX
 PvQwxmR1I9R6cCudvp4CTOeuXpXRXMuB+8WiuQxEr4G1Tu+bpTrt3wM+Uql6h1MHvx/y
 dsULCgMXNn1SBNExrX/npaOk0fb5EXGhWIVPYiYYq3f2O8xhnG/XL7L9wRejIGAEUvDo
 6rz59IP86EpXX8zwnCDzC/qtDRXx2DFB9IzdmGVjzDz9uSdDtA9hKXPqDgClC37qL4BR
 9V91UqPydOosmEgc0l9SRfPoP0Y7HfURkDTyfHSiBk7+Cqyhqk/8eWcfvggbw+8hpTMS tg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qrtta9hru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:19:27 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:19:26 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzhUcwtZ0TjYifcBprq7tjcJRfKrXmOYgcnsNxuJBo8=;
 b=hvWMeHc+TjaczD7ZZZI/i+ldj+XDGV2xVIzHEyTYW+0YorpdLUCg6PhktYPv8/qmQTzJwhugD5BXToKlzCa/riRNT6m3YWTk80zs+/fx/OzW2t489bUfaqU0sHbRdm4lue8+uS1jt/RjNYTkJIOtggoo3NlB7Dt9cmKR4o7OZfk=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1141.namprd18.prod.outlook.com (10.173.182.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Wed, 20 Feb 2019 11:19:24 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:19:24 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "sunil.kovvuri@gmail.com" <sunil.kovvuri@gmail.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>
Subject: Re: [PATCH v3 0/8] nic: thunderx: fix communication races between VF
 & PF
Thread-Topic: [PATCH v3 0/8] nic: thunderx: fix communication races between VF
 & PF
Thread-Index: AQHUyQvNOlcO8xFId0+BQURXujZvyKXoiiuA
Date:   Wed, 20 Feb 2019 11:19:24 +0000
Message-ID: <20190220111923.GA9566@localhost.localdomain>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c5ab5c-393d-4206-080c-08d6972544dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1141;
x-ms-traffictypediagnostic: CY4PR18MB1141:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1141;20:3FOXWbZeNr3qwJpO7FQsUATfCdUh/VCZJktz/Fsg138Ht1cYxC4/9r2nsBNahe2JxplAB8+V2T4UXkKgjkIAgHCMzLPkkZ6X8lvtx9zYVK2ifYY2lshCbv2l0YoXy4TqKTiyyHc7fKEc9zZJTdCUmv7F6CiVBI1XUNVqMDX4Lnk=
x-microsoft-antispam-prvs: <CY4PR18MB1141A75CE2DB0F3273B64125CD7D0@CY4PR18MB1141.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(14454004)(478600001)(11346002)(97736004)(71190400001)(486006)(476003)(106356001)(446003)(33896004)(105586002)(256004)(102836004)(33656002)(2906002)(6506007)(186003)(26005)(71200400001)(25786009)(2501003)(110136005)(1076003)(14444005)(68736007)(4326008)(5660300002)(6512007)(8676002)(53936002)(81166006)(9686003)(81156014)(7736002)(6436002)(3846002)(8936002)(61506002)(6486002)(66066001)(305945005)(229853002)(2201001)(6116002)(86362001)(99286004)(76176011)(316002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1141;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Krw223kaIe4L0chAkz9yUqveHesoDcj1hW4zHAheT3D6CJXiBDzJaRQ/yvGyO03r3Fq98WEt+iQghNxkSkv/5R+SFKV9f8cbSfodJ+6+ly2tvc6nP81oyx5BRhqpgsj8RbIiKqkIa1a5bRXuMMwfAj4QfEerrYSY3nBMBTYz9XC+WuuLw8sj9RF0WVmeNUlIMtc8EJxE6mmhm9apZg4lu9sGWDRnBipNl8uoHmCKj4zgbSHfBhFvL3vrXzJXfTFIKfklvcINXaRHpza+E8DSTP++4HfzEKWg/fP03adhoyU/f76W0pzHB3m7NTaFbT+mpSHIgpoxMvLr676dvjYSx5ed4EQp2YwtvsH0Kep/xkxxx+w9/yDyzaGPQIE/JyNAfMTohFBCf0cosXD3JA2Xn+rGokgMGO56+1N5RdPrj2E=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DC2946DF8EC0147B98A4C28DF302C7C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c5ab5c-393d-4206-080c-08d6972544dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:19:24.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1141
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_10:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=743 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for occasionally reply to old thread.

On Wed, Feb 20, 2019 at 11:02:42AM +0000, Vadim Lomovtsev wrote:
> The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface
> to communicate to physical function driver. Each of VF has it's own pair
> of mailbox registers to read from and write to. The mailbox registers
> has no protection from possible races, so it has to be implemented
> at software side.
>=20
> After long term testing by loop of 'ip link set <ifname> up/down'
> command it was found that there are two possible scenarios when
> race condition appears:
>  1. VF receives link change message from PF and VF send RX mode
> configuration message to PF in the same time from separate thread.
>  2. PF receives RX mode configuration from VF and in the same time,
> in separate thread PF detects link status change and sends appropriate
> message to particular VF.
>=20
> Both cases leads to mailbox data to be rewritten, NIC VF messaging contro=
l
> data to be updated incorrectly and communication sequence gets broken.
>=20
> This patch series is to address race condition with VF & PF communication=
.
>=20
> Changes:
> v1 -> v2
>  - 0000: correct typo in cover letter subject: 'betwen' -> 'between';
>  - move link state polling request task from pf to vf=20
>    instead of cheking status of mailbox irq;
> v2 -> v3
>  - 0003: change return type of nicvf_send_cfg_done() function
>    from int to void;
>  - 0007: update subject and remove unused variable 'netdev'
>    from nicvf_link_status_check_task() function;
>=20
> Vadim Lomovtsev (8):
>   net: thunderx: correct typo in macro name
>   net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs
>     to private for each of them.
>   net: thunderx: make CFG_DONE message to run through generic send-ack
>     sequence
>   net: thunderx: add nicvf_send_msg_to_pf result check for
>     set_rx_mode_task
>   net: thunderx: rework xcast message structure to make it fit into 64
>     bit
>   net: thunderx: add mutex to protect mailbox from concurrent calls for
>     same VF
>   net: thunderx: add LINK_CHANGE message handler at nicpf
>   net: thunderx: remove link change polling code and info from nicpf
>=20
>  drivers/net/ethernet/cavium/thunder/nic.h     |  14 +-
>  .../net/ethernet/cavium/thunder/nic_main.c    | 149 ++++++------------
>  .../net/ethernet/cavium/thunder/nicvf_main.c  | 130 ++++++++++-----
>  .../net/ethernet/cavium/thunder/thunder_bgx.c |   2 +-
>  .../net/ethernet/cavium/thunder/thunder_bgx.h |   2 +-
>  5 files changed, 144 insertions(+), 153 deletions(-)
>=20
> --=20
> 2.17.2=
