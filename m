Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1ECC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CypCJV9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1B220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeICLAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:00:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51418 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbeICLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:00:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w836ZU1S019504;
        Sun, 2 Sep 2018 23:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zRBXIeD2ZKACgtTGnAokZMBl8ywP4Erjj6NaBA4/uzw=;
 b=CypCJV9rmmbBT4HeuT8sD6GVNFhY4TTaMNytmntbxodOgPyWh7/c3KuS34PAUaWcgmem
 Ye+v4Ry+tyPLGx9lhLJ7jupTBkIxZwWJtx4Mv9+MaxZiN0LRlMD6on06gRLY1/eLsvW1
 Hbd9MuN9g7rtph7igNw+pyt9taJaImSfWV8UuET3vgoPoc3irPdxsj0NKY694ChPIadK
 ismCES5p6o/TAc4qtgN6WnlJutmzyQsCh7v75ReVEqGXHpaIJfH5TLdHlpTcxZ+lDCIm
 UlYQsGbe2g1LuRH1XFuS/HA/f1mhT1luaBySJKEGJkDoRJWrHZPtN/FLnp6Zr2Tx7cBg 9A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2m7r4jw5kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 02 Sep 2018 23:41:51 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Sun, 2 Sep
 2018 23:41:50 -0700
Received: from SC-EXCH02.marvell.com ([fe80::980b:63cf:b3c0:7c95]) by
 SC-EXCH02.marvell.com ([fe80::980b:63cf:b3c0:7c95%20]) with mapi id
 15.00.1210.000; Sun, 2 Sep 2018 23:41:50 -0700
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [BUG] net: wireless: mwifiex: A possible
 sleep-in-atomic-context bug in mwifiex_wait_queue_complete()
Thread-Topic: [EXT] [BUG] net: wireless: mwifiex: A possible
 sleep-in-atomic-context bug in mwifiex_wait_queue_complete()
Thread-Index: AQHUQdNwQvzOjf1e6kuCtEe7W+Tzl6TeHe+Q
Date:   Mon, 3 Sep 2018 06:41:50 +0000
Message-ID: <5fbe17917c344f318c25a688f2e94823@SC-EXCH02.marvell.com>
References: <35980039-f268-2db3-5c7d-19ab0c917d44@gmail.com>
In-Reply-To: <35980039-f268-2db3-5c7d-19ab0c917d44@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.93.176.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809030073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhLUp1LA0KDQo+DQo+IFtGVU5DXSBzY2hlZHVsZV90aW1lb3V0DQo+IGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9zdGFfaW9jdGwuYywgNjM6DQo+ICAgICAgc2NoZWR1
bGVfdGltZW91dCBpbiBtd2lmaWV4X3dhaXRfcXVldWVfY29tcGxldGUNCj4gZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2NtZGV2dC5jLCA2NzM6DQo+ICAgICAgbXdpZmlleF93
YWl0X3F1ZXVlX2NvbXBsZXRlIGluIG13aWZpZXhfc2VuZF9jbWQNCkhlcmUsIG13aWZpZXhfc2Vu
ZF9jbWQgZG9lcyBub3QgY2FsbCBtd2lmaWV4X3dhaXRfcXVldWVfY29tcGxldGUsIGJlY2F1c2Ug
dGhlIHN5bmMgcGFyYW1ldGVyIGlzIGZhbHNlLg0KTm90ZSB0aGF0IHRoZSBmdW5jdGlvbiBtd2lm
aWV4X211bHRpX2NoYW5fcmVzeW5jIGRpZCBjYWxsIG13aWZpZXhfc2VuZF9jbWQgd2l0aCBzeW5j
ID0gZmFsc2UuDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9tYWluLmMs
IDEwNDY6DQo+ICAgICAgbXdpZmlleF9zZW5kX2NtZCBpbiBtd2lmaWV4X211bHRpX2NoYW5fcmVz
eW5jDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC91c2IuYywgMjg4Og0K
PiAgICAgIG13aWZpZXhfbXVsdGlfY2hhbl9yZXN5bmMgaW4gbXdpZmlleF91c2JfdHhfY29tcGxl
dGUNCj4NClRoYW5rcywNCkdhbmFwYXRoaQ0K
