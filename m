Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA44218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ijbJ8nx4";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="NTkoQe9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfAYJ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:57:22 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57106 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbfAYJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:57:21 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0P9tTv5008135;
        Fri, 25 Jan 2019 01:57:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EQnQqwY/tm8bc71raR2DrJ1FKi0tEnl9+qqUKaWURSw=;
 b=ijbJ8nx4Qb5S76xjc4f0cxcT+SfQ6VAB1u+5N4UapwQsofjUaa6vavFgFTg3nDOfnX66
 GLpX8bTfA6shJUjwcCt/6eYdmr9NLPn91LszeGJ26R9PrTQsYHWMAAy8TVGYrvaiF6rb
 sTEvVUCBulTWsighzziNbKz4eCCyHa3nepKvnIA7ybB5Nu56itCjgiw9IPtlQauicurH
 l5Q0DW2vIsYAc3gq5nBnOjBY0s2evIWmYGbApzfo1U7hXcD05Rki6eIQPaRH/d4RZF/y
 X1BbRhsKKBvcv1+tVotjylDrkHIbGYvtfQI5/gwLACgqeyJ9/xC4kW9Quv5wfF6LnZmK iw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2q7q0kjyk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 01:57:05 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 25 Jan
 2019 01:57:04 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 25 Jan 2019 01:57:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQnQqwY/tm8bc71raR2DrJ1FKi0tEnl9+qqUKaWURSw=;
 b=NTkoQe9HmlBh2zxZuCY9MvWT7YPF1mCoaqo9K1QmfS0eHtuy4lojSlgelViTP5KJaOSHyAfQAIQmkduo2J9Azc6ohWHy3sU5y2uk5YRW+pJ64orItscDVlh6W022FysH8INCQhepgP4rhSM2Ci26OL0N7zZ7odbxvyZcWixU4MY=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2763.namprd18.prod.outlook.com (20.179.49.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Fri, 25 Jan 2019 09:57:02 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c%2]) with mapi id 15.20.1558.016; Fri, 25 Jan 2019
 09:57:02 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Thread-Topic: [Qestion] Softlockup when send IPI to other CPUs
Thread-Index: AQHUsFLrrYWN2sDbSEeIkTghgif1Ug==
Date:   Fri, 25 Jan 2019 09:57:02 +0000
Message-ID: <DM6PR18MB246092A6734074485E33B8BDD99B0@DM6PR18MB2460.namprd18.prod.outlook.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190123181530.GA234790@arrakis.emea.arm.com>
 <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
 <20190124163743.GK253679@arrakis.emea.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR18MB2763;20:rm92w7eWfDKzl/uwcR4WZyxu+OyC0FzWAWNxN2Ku99MG3TZygzQT5iTRtnCWx5sYweHl0+qkaVo2b2If40yz/n8m+NZKruzewkLPs+4ErG6VvE4wo+dHsTznc0H56sCm3Qyf/GxW1a3LOH0rGPWPd8HIyM9/lP2eP3hF2vcA8do=
x-ms-office365-filtering-correlation-id: 31ffa278-ebee-4e27-ec9e-08d682ab74a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM6PR18MB2763;
x-ms-traffictypediagnostic: DM6PR18MB2763:
x-microsoft-antispam-prvs: <DM6PR18MB2763791EFC12B61359CDAD03D99B0@DM6PR18MB2763.namprd18.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(93886005)(102836004)(26005)(229853002)(14454004)(7736002)(305945005)(71190400001)(316002)(54906003)(6506007)(53546011)(71200400001)(7696005)(6436002)(76176011)(476003)(446003)(478600001)(4326008)(6116002)(186003)(68736007)(25786009)(106356001)(105586002)(97736004)(3846002)(486006)(66066001)(966005)(8936002)(8676002)(53936002)(81156014)(81166006)(9686003)(6306002)(6916009)(99286004)(107886003)(74316002)(2906002)(6246003)(256004)(78486014)(33656002)(86362001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2763;H:DM6PR18MB2460.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EoDQtdT58KuQXJPzCeSHteCUSaS/RieML2JXob4IhTlXq1FYURTbMp1xloqQgKntZWz3sMu6pZu56ks3NFrezw08Ps/qKOFL65FiRW95OaYYA8LW2RUe5OShPvYLTdTiPzUC54NY36HuoWrbnv8SqTjDDx/o31r/slqqlXUAriX+zrfRdRvIdbC45AW3NJhpZ80KOLljyte+mVnipxPUckqCT3TzNsToizmcDgeuO491RyLBMiIdt5bOCC3QU7cAPlptMhcydwm8l1EzvdKTzoqm+2IU6m9ZERnzV8GCsTXkZP8TRu1TqLqcs5nu6pDOnSrDvzZN4HfyhlprpvI/GV4/R2TeGmjV5JVKwiobRVUIKX7uENKphn6ZCrejgAKCQPliSXdA4iK0dou5DR6Gf117InxAtBws9viOTp0sB6c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ffa278-ebee-4e27-ec9e-08d682ab74a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 09:57:02.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2763
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_06:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=647 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/2019 10:07 PM, Catalin Marinas wrote:=0A=
> Hi  Shijith,=0A=
> =0A=
> On Thu, Jan 24, 2019 at 07:00:42AM +0000, Shijith Thotton wrote:=0A=
>> On 01/23/2019 11:45 PM, Catalin Marinas wrote:=0A=
>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c=0A=
>>> index 30695a868107..5c9073bace83 100644=0A=
>>> --- a/arch/arm64/mm/flush.c=0A=
>>> +++ b/arch/arm64/mm/flush.c=0A=
>>> @@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long =
len)=0A=
>>>    		__clean_dcache_area_pou(kaddr, len);=0A=
>>>    		__flush_icache_all();=0A=
>>>    	} else {=0A=
>>> -		flush_icache_range(addr, addr + len);=0A=
>>> +		/*=0A=
>>> +		 * Don't issue kick_all_cpus_sync() after I-cache invalidation=0A=
>>> +		 * for user mappings.=0A=
>>> +		 */=0A=
>>> +		__flush_icache_range(addr, addr + len);=0A=
>>>    	}=0A=
>>>    }=0A=
>>=0A=
>> We also faced similar issue with LTP test migrate_pages03 in past and th=
is patch=0A=
>> fixes the issue.=0A=
>>=0A=
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/62357=
4.html=0A=
> =0A=
> Thanks for confirming. I presume I can add your tested-by.=0A=
> =0A=
=0A=
Sure.=0A=
=0A=
Tested-by: Shijith Thotton <sthotton@marvell.com>=0A=
=0A=
Shijith=0A=
