Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E58C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BBF2723A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aqjy3DuN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aCLvKSoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BBF2723A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030277AbeF1Qsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935837AbeF1Qsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGmNvh016262;
        Thu, 28 Jun 2018 09:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=aqjy3DuNpyjH+eaBGbUHGTqgMfTuVpGAq23PQ+IQlUGOzG+f1ca8EwYk4ufjqUWOGDld
 k/pOclf26klNXoMO4cLqWKAdpKWk7IMsSetATMqZ8yby7k2rhe1T5kB8PpOhGDdd5940
 nahBLCBX4cVb1S6P7KVKsEDpYB1y30xnZKY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jw2h4r8jp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=aCLvKSoeDjihUqJDKWB1UsYW8z6yey1Ouxi2VoRncpfHZ2U8r+HxKQU4vPRtD+mRl78cg+Qfb5DhBPhL4OvWfoXU/+62GmbvxiStEYAusui677EmB9YrG9gOaTDdCzKb7zduPnTC99nYL7ob26HFfkNVJbYHvnjf3VgscuJbprk=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Thu, 28 Jun 2018 09:47:17 -0700
Message-ID: <20180628164719.28215-13-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cdd0c29-400e-4d64-4dea-08d5dd16ee50
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:Jom9tTirewhg7NuJM2NXCJX0wXhn6lfGMGaw/wD2PMtMncI1jT9G49i7EVc3E10eXCHnYdRr6ZM6UgNg4xgzYob49AOHb2Ftf+XXaUZqkzMLBsYdc0xSOOxO5X8VUhT7MYF/toK/0571eAWhpqWvu5bwvO3/0pqXcDsx0dtqTKzYqiSinPCDEcC5YKLFPf/Y7XpL86Xbu8BH7tkRd4qBcUYVfE99LkqLDASjad5+0C0Zn1ilV/9YhK5L+Reje98M;25:PzkJQxp299IISz0ctncFXqdFMOG0uZvAT8VSxhkrZxrSsJQTue/PGh1CI4ilinziI/Sy6uN1128m+q3uMrxSgx35R7Yb1pzZdGIwT5wiJqKUJkVomnK3tDfnAPaXmcAyWl40C1N9FWA3w3nVFOtQg3mpF+l496BBz4moyiuJ34jvTiay3h7IXxBngcCQaMuNBTMb8igdvlnIC3RH1nmvmkD8artXCzLbWn5eM0D7UPqW0xZVs12M57zu+cjW6dHIDvRwIqzmEzynICq80Hj+grgSteA1u8mw17gaNSCGGkXzwAGjikv9zLmChpLheEgrSmSGCiwhhqNXUYeYShyu3g==;31:V768d8fygNDi8hAumKqayrdZEXONIsUVe4Jfklxoywc9MQDTCpytDDE5pLDSMYxcxkRGq71g4HUC0rD8Dw2/4yUTwBHi+z7PPuUq3w3AYlI7RPAOEXSEkTAd3yjJML1PwFzfJELvrpGdh6oJQTiND0RuQ1NRnnFEoDwsSkMqFgjYqXN4hwBDn4gHM3H2UbT6V6PtS82JQgclpmmO1zU4/qMCSm29ZhZiOuUtBo6NvXc=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:0X1OTEbY/QiPj6UODnD/0599V8j+cGnXkjjh6k7YkoIgESkd+O6SQ81UMZkLlhEmsqbwpt6gv15M6dgeUd2O98Q2dFsPbWNpGTLfbgFX7JMHLXqlnQme9CzSqAXK7iTTSvM1EwwM40DfX1ngT72OxuxZJ9fChZifzLciwYCMODbgm0ASqj9DZnqhtvmo2XVOIgrEK1s3Qe8K4ZyWstknk7yG0GYgxwjErmcFttV6ghZPSrRvBuf2EyV0XaipVZaUr9yWsOeXXWD85cv021Mwq123mP+DGQbGpKQTZRN28ep+HFpQxJk6/mzA5zTW2v+Si7qne68OCJfBRD8EHrs2VcwcE9Q+wXjQ0ZGf8pgwQ6MVv4fR5BH9wliTHOGi7RM8DCdtUlFj3RjrGnO6CsEJWULoltJsHqbxsXR1FWBvgsFKwgRoHo00FNk30gzwwnhY+GgEqipqFlx/E/p9sZjHGwPNXiNQ+DJz3r8Q9jTc8Nh9Eqm+0dVo8aVEAgYCEfkG;4:2GvUAEWA0dyEzBsmzMSi8Hv0G0BepokVPLusqfulJ7OrlNCNlq3bz76Uj1Mhfl6GRBAOvcMhtH2HVLetcoEOLL3Su7KZdocIYQyc5emOXtHCUkobP3WByzXXLZJLqzxYen3lITycVbHlwqPOkE3CskqAHrPp8JPeqXObubB140JWh5BampBEYTpPCJKYj0kSXtlE6tjgddFTICsZrRJhyE14yxro6LGCK6K7ImbCMrkSEViaEUJE4Yxrur/R1mW0BUNmWO51TzEJCmEsFBJUZU/dDRNNGqLaKAowWm6quKzqNwQ8CzllsORn+M6OKYx9
X-Microsoft-Antispam-PRVS: <DM3PR15MB10810EA9B4B0E82DF97D68CFBE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:BqcIhjvGy4XHnDH7Qi/ABiBl/pPa+Q6PTQZNvxJfo?=
 =?us-ascii?Q?Oya8fHZ+QgRf51awU+uEz+7AO5dj3YhEZYeWpWBFU0s6IXPsio3GslOxDOHq?=
 =?us-ascii?Q?WMTL/eVbtqrjShfbJ80whSaeYeWUvf1JbsGtVS5uqdMlRFt5IjL00UtqJzcr?=
 =?us-ascii?Q?BRxZd3UfV1kF/I40WHzESGjVrNVvruaU5aTV1Do/RFO0YlCTnckSj2JboczE?=
 =?us-ascii?Q?aTaRROwAupzZsdjqDaxP9V5Hotp0GcBmsZx/VcP3rzg29maYRA+iv+y8nOr+?=
 =?us-ascii?Q?FEdygzjJcxgrsy7bZW3iEk1WsAoRo/E586cb8M+PXLR2B3l2c1RuA1BVxNn3?=
 =?us-ascii?Q?G+Rc9AnI04wpdEDu6Hz1KrXnboH5nvwLK/+0pYG9Zn00u0svYXj+J7ksFAwl?=
 =?us-ascii?Q?P7YZMQ4HgfTRGzDAEzALH0iR2HHebz8WBSN/2eUoed8n898TEHhxPeordGEI?=
 =?us-ascii?Q?ay/fwz0yDL1gz9Q7Hl++nayjXteXVKntj1R9wpkUSV4/KwZE0YgdUbuXEmtB?=
 =?us-ascii?Q?85y9pIRAfi2TvePAas3QJ6wQYOI/iVrAd4wyCY+NMNcrhqvgKh9qIVqQWfLQ?=
 =?us-ascii?Q?m5vgMGS5ETG0e2SmVOLSOE268FNJV0WMiRV4IoKMtqQKmSZZvLn+mxZbSgRX?=
 =?us-ascii?Q?Ubboo98ukmVkgfAtJ8qsneyI/b0BC1jHDqiPQuElKusK1K/fmmKXt5E+UENv?=
 =?us-ascii?Q?M4pGGmbnfnlrLVhJF/W3N5auSHBJZ+US+nJ8qchYz7Ekv8h4ra4mkJ/o4/7N?=
 =?us-ascii?Q?xjf5lm0m0OiTxYFD+oLxyGba1m25Z1sJpyLNmhp+I+FSp4XM8cdMcuNqUgrM?=
 =?us-ascii?Q?aFga5d+AAvl3TM3yEZl9IC3pMMr5FbmSuCguqqbRIjwP9QiIlIb0o33ZmQoS?=
 =?us-ascii?Q?gIjVY2puSsYpSpXusblIEV8/rLvVYyme93ABZJVAmgypQrG2vRlDpLk1Ui17?=
 =?us-ascii?Q?OiL0b8z95eYO1kmewXY7RTg4sxCpuKoU+LuJqDab9P+ClKFVZeFnS3bAHxIS?=
 =?us-ascii?Q?xv5SA6S+4HCJKjygs54FlpfghOdUWwvYzhQO92tESDqMT0ugCHW9x2vbDez8?=
 =?us-ascii?Q?+uxnSbgk6JMoZ8A4Zk+jQA+IpSiybHrxsLVRSqMo2CenkCwpjzAECEmCaAtB?=
 =?us-ascii?Q?FZa9y8i4CY3eVacrnbV7fZ4TWb+nKnUJSTBhSJTCzNQphdGFhJr66UUxUiLt?=
 =?us-ascii?Q?GUtcQtKd3eUcpRV8KlZbk60ENCNPyjYx3NxPOttU/4W+jI3+VTiA7LuMHwrc?=
 =?us-ascii?Q?jBO+4zr5nTCQbzFJuBtUtJOzX8Y0NYFBlawBSyQiAi2RRcC0CcxfzmKFfEC6?=
 =?us-ascii?Q?R+5DVMzFFx2jZcL14u1amk=3D?=
X-Microsoft-Antispam-Message-Info: EnQ9oSf5Vk/uQn0dOvOPQqh8Tp2vTlxIEgIMWZVLs9AXcFn6E1ADurRkjNlIrw3OWVhss2ga1xe5xZhFTAi4WIHy68fYmhXqy9Wi5w5p2ZtZWcLDThNBsx+PZXrL7KtZQGqU49LGmKxJUnd5jagw4LjAccbrBaLZOw8K7cBHRB/1vOQZq3hvO6bAnBOemewKjfKRATPRF6YRU6pwfkINFKIGXnbxAqtGwiz48oDlNVcBBCEiKKQpnJBWodnpKa4mpPG09AZp64YGzOLFiI95vT++HRPaxw0l/4hcI3fLIz7ZSVxiVOIWmXcB9qiR7e5uZxlxc9y/qIs8mPmCQl7bWx30NZbKumtzmaSDXN+2x5o=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:uXr1mcvFz6JSen/dkbiWbMGUgKqFNzj7+P2Eo3CBoHqa2dNobhVxLLX4ys1G9hhJ+A1YvEzBEWu9l8CeCXDneNWWjhgb/BPK+XECebaYsTiMO5xRUXJxF5LJPEx08YQofLlbbeLcjMwj7zXpyYa/9wYLChU1QvIADbHShz6uGLJ4eKp9ScALPcyrl8eoITEmJHVQqQoOeJ/GswbgV0guBSL7RwjpwHbkGiTcfOHfkmva8D9sVumohTYLfkB3RbbcUvxC0jBTWDSNLBjvOhfJzKIXg6M/m1Yulo7EZMp2kspLNM9MBcAGjlwyIyNXI92XEyhPJB5yWuWZhKl9dkHCa17N5nlxRYUOpERVwePos1Hh80wV0zyRoIo3hKmEAet//cUVHhvQ6DjgpGOCZzVe+D1D+z2diYhxK5zAAUq+PHrFJDsEHI05wiQ0gAnDdSQh0g3B/joDlBRR/B2w02Ha6g==;5:GD+vTefNAZGG/AySZUsrjGs8OwZBV/MQ9vT21+js5j2Yz27G3mWV7IREMPTQdo3jfOkd/p33PKf52AC4y0WAUe4O9Z8f3OMZnLKLVZ4Xh2PDFjVF7awtNA0AdBA4tLnoPsLpovo5U1wxJBGdtbzEvSBPtxikhDG4q2ftcIQso0s=;24:PbOP/jCU2aW/wsOvTnM9kAm+lb/MO6yOAojzi3rPEXg4OzHLkewyOeUQvXCs2WwiAGjVmhOcPrhScFcC/07/b3IAPYSBBB7kyhqcgmLyr4I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:CO8TvZOKNk/rpDtXrgp8Y3ABgikYhO+DoucrI68LqzkATTCDdg+zzr9yuD0Lnl21mMzhOln9ROYyLYn/MmwC5W3x4VT6WfFay+i8Lob7kzBHri3kn2Z+nW8pUa517LBCEgpN7Rj9kX/t7LIThY06pNuNetuWha73LYnpmEjJFsuesezavywAvuGX/k6z4EJyZC55sUG9hXnODRfQiplaPHCxb3g/vgIH6fN8fjkixFpw1giFzrsNt+83zY8ocvLr;20:1CpOpTdRCA4YaawcRBL5qHuChdui+xEx+BikGy4H/Jr/se/Uc+hbDvD5sQJ2psb1sR+UMDZbFugjIpY4qUzSW9SwAM/tE6Kl2w4VIuxFvdqPb/ZU1Dv5wCONq4cCb227+xgsUKplwCo04kt6SG+JkH1GK1SrvTQhaLScvhrbujc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:09.2864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdd0c29-400e-4d64-4dea-08d5dd16ee50
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following verifier tests to cover the cgroup storage
functionality:
1) valid access to the cgroup storage
2) invalid access: use regular hashmap instead of cgroup storage map
3) invalid access: use invalid map fd
4) invalid access: try access memory after the cgroup storage
5) invalid access: try access memory before the cgroup storage
6) invalid access: call get_local_storage() with non-zero flags

For tests 2)-6) check returned error strings.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  #1/u DIV32 by 0, zero check 1 OK
  ...
  #280/p valid cgroup storage access OK
  #281/p invalid cgroup storage access 1 OK
  #282/p invalid cgroup storage access 2 OK
  #283/p invalid per-cgroup storage access 3 OK
  #284/p invalid cgroup storage access 4 OK
  #285/p invalid cgroup storage access 5 OK
  ...
  #649/p pass modified ctx pointer to helper, 2 OK
  #650/p pass modified ctx pointer to helper, 3 OK
  Summary: 901 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h   |   2 +
 tools/testing/selftests/bpf/test_verifier.c | 123 +++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index f2f28b6c8915..ccd959fd940e 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -133,6 +133,8 @@ static int (*bpf_rc_keydown)(void *ctx, unsigned int protocol,
 	(void *) BPF_FUNC_rc_keydown;
 static unsigned long long (*bpf_get_current_cgroup_id)(void) =
 	(void *) BPF_FUNC_get_current_cgroup_id;
+static void *(*bpf_get_local_storage)(void *map, unsigned long long flags) =
+	(void *) BPF_FUNC_get_local_storage;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 2ecd27b670d7..7016fb2964a1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	7
+#define MAX_NR_MAPS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
@@ -70,6 +70,7 @@ struct bpf_test {
 	int fixup_prog1[MAX_FIXUPS];
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
+	int fixup_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4630,6 +4631,104 @@ static struct bpf_test tests[] = {
 		.result = REJECT,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"valid cgroup storage access",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 1",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 1 },
+		.result = REJECT,
+		.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 2",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "fd 1 is not pointing to valid bpf_map",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cgroup storage access 3",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 5",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12418,6 +12517,19 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
+static int create_cgroup_storage(void)
+{
+	int fd;
+
+	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+			    sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, 0);
+	if (fd < 0)
+		printf("Failed to create array '%s'!\n", strerror(errno));
+
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
@@ -12430,6 +12542,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12497,6 +12610,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 			fixup_map_in_map++;
 		} while (*fixup_map_in_map);
 	}
+
+	if (*fixup_cgroup_storage) {
+		map_fds[7] = create_cgroup_storage();
+		do {
+			prog[*fixup_cgroup_storage].imm = map_fds[7];
+			fixup_cgroup_storage++;
+		} while (*fixup_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.14.4

