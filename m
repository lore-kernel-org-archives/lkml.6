Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18055C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD16218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MmZXWJpg";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="FKzBpwsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfBRJyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:54:10 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56036 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbfBRJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:37 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1I9qE5b025142;
        Mon, 18 Feb 2019 01:52:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=LOE+25pPYfmKDG7wyiqm+Gv37rqQ2rPnP33iBRu+YPA=;
 b=MmZXWJpgnVcnDW/6jTWLJYgBoH8y8X4EjGtf9mFePyi+4FN5oS/xpMdra0eKOkBQ+fck
 LYwWQsuisoi1jo+BlUkx3MjoidYepOvX5DPT1zGFzKGDwwWJr+UUKCrhfBbr7ZXormkq
 FtMpXguMq4P5UE8UFbHv/17oyfYqTf/+dGJ9Xi5sVY/2ikf7qqDdd7BzaRvJvnCQH3D9
 8EQ+lBKS35AVLSQA/Z4eIfzue0fri3QSMPui8i0NR1LEBMA52xdJZtEvz7Pf5JFJxELJ
 sd0gLNVjYGdOkHzATcHIdrOuCQGFytB9zVr3IGWGtfm3KmUTiNx/ypBAPjOCwT0gFmQi wA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw14e-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 01:52:22 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:17 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOE+25pPYfmKDG7wyiqm+Gv37rqQ2rPnP33iBRu+YPA=;
 b=FKzBpwsqyDlDt7VIbZrHbhvcaZnYNXodLRTgRmdJqRWTfrc2Ib4dCDGdyM1QMc0+BUZ4dUNTQxNOAu+Xr1//Z5cDT4q/2Ovywm7b4zosM/6IoGXPFHj5YCWKQnWZ+JAkDpFkSTOh0m6ya4UcyMmgKccOKOyFgvgJuaUDUj+F/HQ=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:14 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:14 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vadim.lomovtsev@auriga.com>
Subject: [PATCH v2 0/8] nic: thunderx: fix communication races between VF & PF
Thread-Topic: [PATCH v2 0/8] nic: thunderx: fix communication races between VF
 & PF
Thread-Index: AQHUx2+f14WSblrWyUeOACPWjEMbhA==
Date:   Mon, 18 Feb 2019 09:52:13 +0000
Message-ID: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af0bf6d2-8447-42b3-ab8d-08d69586c29c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0968;
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0968;20:XdMQGaIdin1AL9UUoBgdamPlUnkf5O586ESAvSTdEHaqaW+Yfytnj+YP+vJXGWZYKp6YxsYvS1Yn8pBXVEVwVXxL3lLsIK+JucQxUh29D0pXxQ5E4zXKlyEsQy5EWwitpvwt3rjkGuBVfUYqrO4vkb2NfZSB0W6mfoQsnJuNKwQ=
x-microsoft-antispam-prvs: <CY4PR18MB096855017E7FCBC4A0D5AA0ECD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(81166006)(81156014)(6436002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0968;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XY2CEShGRlgs1ZLm/+FEyvHWDBLNERPou2nYUHWfvbTBZIrkvui8I0HJieNGNVDxiaOfewOfL/Vn+lSR801djugZImwOoVTkzqi31Iklp8ALIjBavaZKLNgq5z/5IZJU0U/VnkSi7XJ5M5ggdzNIAbH/Lujb0hBmeaH1HZQxxU8qRa18d3cHvRaZj4XDPq51PRKj4R12iydT5GFntcGWmaK3VwLHpKjKPNnOjt8qZ9JSZbY3vg3b9VXhsyBQA1OJiDLXx7BhQbAdJz++McZdp8nt8oLjUBwQYQQVrxcNHGn0pOwJI1656FITUqY5TH2iW5TzjylC2j8Ejee+teeyTduWx8mNM3ITQEbzw05CrQIBPmsoAilXJ1MIP0B0+8qoTEQYI1FFEPCynuI+atkQC03V3J+beQECpn27vpOdY+A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af0bf6d2-8447-42b3-ab8d-08d69586c29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:13.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0968
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=407 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <vadim.lomovtsev@auriga.com>

The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface=20
to communicate to physical function driver. Each of VF has it's own pair
of mailbox registers to read from and write to. The mailbox registers
has no protection from possible races, so it has to be implemented
at software side.

After long term testing by loop of 'ip link set <ifname> up/down'
command it was found that there are two possible scenarios when
race condition appears:
 1. VF receives link change message from PF and VF send RX mode
configuration message to PF in the same time from separate thread.
 2. PF receives RX mode configuration from VF and in the same time,
in separate thread PF detects link status change and sends appropriate
message to particular VF.

Both cases leads to mailbox data to be rewritten, NIC VF messaging control
data to be updated incorrectly and communication sequence gets broken.

This patch series is to address race condition with VF & PF communication.

Vadim Lomovtsev (8):
  net: thunderx: correct typo in macro name
  net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs
    to private for each of them.
  net: thunderx: make CFG_DONE message to run through generic send-ack
    sequence
  net: thunderx: add nicvf_send_msg_to_pf result check for
    set_rx_mode_task
  net: thunderx: rework xcast message structure to make it fit into 64
    bit
  net: thunderx: add mutex to protect mailbox from concurrent calls for
    same VF
  net: thunderx: add LINK_CHANGE message handler at nicpf
  net: thunderx: remove link change polling code and info from nicpf

 drivers/net/ethernet/cavium/thunder/nic.h     |  14 +-
 .../net/ethernet/cavium/thunder/nic_main.c    | 149 ++++++------------
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 133 +++++++++++-----
 .../net/ethernet/cavium/thunder/thunder_bgx.c |   2 +-
 .../net/ethernet/cavium/thunder/thunder_bgx.h |   2 +-
 5 files changed, 147 insertions(+), 153 deletions(-)

--=20
2.17.2
