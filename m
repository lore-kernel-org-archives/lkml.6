Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF10C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70620835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="X3+NLef7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VQ6Mhq7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B70620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJLGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:54:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeJLGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:54:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BNICcV013231;
        Thu, 11 Oct 2018 16:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CK4lZimKLKe5xOMTyBztinIkORn6qnW9YilfFLJW6Ak=;
 b=X3+NLef7vsD+gLNejl6O6wQvwvlcBhYYxL7xcphGygeUxbrRbGep5ZN9jhy2SPFabZQO
 QP1VitshmXRLKTYLN1U/2L/DRAsLA2/D/pVWNeMQoUPGy23mtjL7TuESfAvdwTeN1/TB
 aDQAPuWpgxBWI35zLBCzhb6iL4JiFMNtCnQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n2emn0989-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Oct 2018 16:24:39 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 11 Oct 2018 19:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK4lZimKLKe5xOMTyBztinIkORn6qnW9YilfFLJW6Ak=;
 b=VQ6Mhq7O2ZfFmD4TCaOlhM3kbpqVD5RcNbcElLF0LtR2I61NQBkSfDuz+oL8zOrJMAI1buxMANP20Tmj7QejdVS9Qe4h82u44S7XhRcVQFvoFLKTzvnfuijzq7E0a/NBtW1tyfFvMM/mp7Z+Q5w4EE0zsH7cKKL6DnnyMZP7JsA=
Received: from BN6PR15MB1265.namprd15.prod.outlook.com (10.172.206.15) by
 BN6PR15MB1827.namprd15.prod.outlook.com (10.174.239.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Thu, 11 Oct 2018 23:24:32 +0000
Received: from BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::a56d:f082:a976:9bfc]) by BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::a56d:f082:a976:9bfc%8]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 23:24:31 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "Justin.Lee1@Dell.com" <Justin.Lee1@Dell.com>,
        "sam@mendozajonas.com" <sam@mendozajonas.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUYbb2PU7LFGQsmEiM0XNSz2chY6Uarr0A//+LmAA=
Date:   Thu, 11 Oct 2018 23:24:31 +0000
Message-ID: <78B80A16-90F1-452F-9612-9E6005BBBE9E@fb.com>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
 <fcd53ec5b915431087b7100432bece2f@AUSX13MPS302.AMER.DELL.COM>
In-Reply-To: <fcd53ec5b915431087b7100432bece2f@AUSX13MPS302.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:180::1:7baf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1827;20:HXdgJHy4QQl/XLNGDpFWlD2L+lGJZzKQum+4uMuyIAe73vFiIhOERXu1nYT/o3GXprE8Dz85KC6Np7z3B0cjOSGxvTI6HPsjBgT1sPOSvA9/yn4VVlCjc1DUn86YLLFt1z8Fa39A80HIj6e0wIBbPcdkccXoUdLjv82NF0aEKV0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25fb7474-94ad-4dd4-18b5-08d62fd0b2c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1827;
x-ms-traffictypediagnostic: BN6PR15MB1827:
x-microsoft-antispam-prvs: <BN6PR15MB1827E6DE6710FEB11DDB90CEDDE10@BN6PR15MB1827.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(56004941905204);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR15MB1827;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1827;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(43544003)(33656002)(558084003)(82746002)(256004)(6116002)(14444005)(5660300001)(6512007)(25786009)(8936002)(102836004)(86362001)(6246003)(71190400001)(186003)(71200400001)(6486002)(486006)(2201001)(81166006)(81156014)(2501003)(83716004)(76176011)(6506007)(5250100002)(68736007)(36756003)(7736002)(2906002)(14454004)(2900100001)(316002)(476003)(4326008)(97736004)(6436002)(478600001)(54906003)(446003)(105586002)(11346002)(99286004)(229853002)(8676002)(305945005)(53936002)(110136005)(46003)(106356001)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1827;H:BN6PR15MB1265.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3HPNsN6zHYVxnZW+yDEsoL8k5nEUW4Wq0c4/ZWa4p+ESsQ0qlITHHr7Kpe7agyo6ETJHilAB9OyqIL59boWyJP1BPz6GvrSDrkQk7nltAnsrzWbvlb3P5B4XLeaSDD19zU8KGQt9lyeippYYaKtFFZ3aXB+elUGA8G3jK7YNKc+W3o7e5MhYKkf2nPW78U7z8pXZIfti0b2LbtbNrG0SbGSGGwoFvgy6c6jolav9m9qLpkPtOlKoPYnxo6PpJgLADcfcmALl453x80Tr+CYAmlscndJCDG3O5kZcN+WPGhHKFimZJcpTb3KXpB7ULZ9NGY+8Pu3gpmWJmEo4JmR+LxD3N4yonjCZm8aCi4TdmLs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <15FACCAC8DC17E4CA2659385CDE95775@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fb7474-94ad-4dd4-18b5-08d62fd0b2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 23:24:31.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1827
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzExLzE4LCA0OjIxIFBNLCAiSnVzdGluLkxlZTFARGVsbC5jb20iIDxKdXN0
aW4uTGVlMUBEZWxsLmNvbT4gd3JvdGU6DQoNCiAgICBIaSBWaWpheSwNCiAgICANCiAgICBQbGVh
c2Ugb3JkZXIgYWxsIGxvY2FsIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBmcm9tIGxvbmdlc3QgdG8g
c2hvcnRlc3QNCiAgICBsaW5lIGFzIGluc3RydWN0ZWQgYnkgRGF2ZS4NCiAgICANCiAgICBUaGFu
a3MsDQogICAgSnVzdGluDQogICAgDQogIFRoYW5rcyBKdXN0aW4sDQogIEkgd2lsbCB0YWtlIGNh
cmUgb2YgdGhpcy4NCg0KICBSZWdhcmRzDQogIC1WaWpheSANCg0K
