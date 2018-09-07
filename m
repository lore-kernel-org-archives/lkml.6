Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E065C2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lKDAatgl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="h1q5QRJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E065C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIGVlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:41:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726766AbeIGVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:41:09 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w87GuHRr031596;
        Fri, 7 Sep 2018 09:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=VUjV5rUf8W/KwaQ2siPvqe7zN+oGt0tpOUZh+gJRI+0=;
 b=lKDAatglW1o3l+aXAOe46/4sFSvpavp0p709P5o4Vn0BRkmkFpUYZJwx9upJyDk3QWUk
 QBd2evN8zR6eJQPIP0W7buOmeZqLldzATfwZo3nYYQHYUnI0huyImgty0crvlStxIQ0J
 5y0NYs9z8cdMbkoV3f3eO7xaJtuf+CchTEo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2mbr548uqw-13
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 09:58:31 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 12:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUjV5rUf8W/KwaQ2siPvqe7zN+oGt0tpOUZh+gJRI+0=;
 b=h1q5QRJQmeTbl9Bd2YEOkS3c51gNvGbHfKS8wZeVcpyOifppbfQ2JCs7jqHnkcLTTX3DqKaFWvURxxuk3PA+wCLMrSMoOW7FL4K4wCx8JtPr6Z5A6TwKmabbo9k0/eIZhsr+pNTffAMfyHnL9/Bz0vEWMI7dFadETQ3J+TNnTus=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:168f) by
 SN1PR15MB0174.namprd15.prod.outlook.com (2a01:111:e400:58cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 7 Sep
 2018 16:56:50 +0000
Date:   Fri, 7 Sep 2018 09:56:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <jgkamat@fb.com>
CC:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>
Subject: Re: [PATCH 1/2] Fix cg_read_strcmp()
Message-ID: <20180907165642.GA572@tower.DHCP.thefacebook.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180907164924.13789-1-jgkamat@fb.com>
 <20180907164924.13789-2-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180907164924.13789-2-jgkamat@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:168f]
X-ClientProxiedBy: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To SN1PR15MB0174.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc4cec7a-0d02-4047-df85-08d614e2e822
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0174;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;3:qXONFmsF9Bo7oyNnoPMkp5Ws7qfHMXP/EODduy+Ons6+4cuomhmvsxROU5+Do733ndhdVxW6chOkoAftcrT5zAE9RTGThub0Gw2UV/MQf/VqhHEbJ+E5yQMEC/HfpKle4bVS5pOlKXskFvPxzFgINk/Xuf8HgBucA+a+KYhwPgyF2h0q22vsqrbd81pSJTHJ3mqmRuKpSV3etXsiq2gbRpTgD9Po2morBuaFR4BWkWHIdu5BkLnzJ+PD6xsQaa3e;25:vbGOIgffbNpb2hCHJ4OwIzv7axZQnq7wFm8TaSBoeb+Cp0KX9TqYypUOfjdDdErnDM3YjfmrB6gmzdlnJ9lAlv064YgO0ea/dKstn4LjmQJVgB6gjRTxj6TjJD/bZd6BHBMe7d2THvRgWcsxx85aOaPzjB8b5X+ms0x58iVI+Ve8kvI4ZoA3xDSDG7Iq29K6cWzFMw3ezFHCaNTqcNCdYPeBQgsBigKHJWKEeOVVsEDnIJUAmhKKd1Zrt9vm/IGpOYHhUO/dtQGOd5a5yU6ahOGwfXeCQjtmW0OlGKZLocge1LiOLi5Vvgs3UpTzWz8HOJz9ITMPFGsbDvgGZwSw6A==;31:cz97ue/RbvV4vcZpCGQbKRNpJFYsRf0MZDV8jWTG5h0SK0jpwn07N41vDMtsTQtfq5OYoeA/D+plsYK+b4vhYfT9f89aDyMKVC0DIdeXao7J575DwBx4b+h+aGUkcVlUErYBo+wxgHQvgcWbl+uZXDjWOheZX60BkPouVMnMiR1jnvef5NvXCzxmKSw+xHNW0KsD9E71O44Ahclb4/zWwLv1v2OqbMmADnM4POgXROs=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0174:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;20:xuYQLsEWKmMSXahcbPQgluj5nd2uIqhOGWXTBwIfMZ0onSl53Luz8hwYcXRcn5kA6cpfKw45F/+SSGh4X6I8wVfM1LtpaJ5o8RcvY+D9kK7ju8Vgu1w9NU1CrC2qLE4Ll+Yd5QBrLL16H3Fu3dAlKEpJZpbVqV6Xh0Q4k6ArXDWzizX6pJCa+p3DJwqy8tOce93UOr+XW7eqNlttLxp51wa9WttqkCTxgYOU3AU689pB/ykfypM476LbGP22+fU879kCONUOv5zCc8vGC2xzL1+SEgdG0GO1A4UKlZ2XMJznPxLT/HkMpv3eV02YThobYivkwPwS9V6tD9rWnjnJk57BEOyTTKuR5UX8gofFQj9ccNreZOM3mV/9kJsZpMfFlfAVjjdueUEp2qQCKhl1kwAFvPaVbr3r9nJQZbhm+FLPO9C8j+jy/NwrNxFY/vmH4+EFWz63fF0laoNq4T5j+WFYhG3E/n4F0yTxmiPnh0sX8ookTRRdp9KYd1aXwCeX;4:6Vdp6UPZve0W71e+9TkbVXPpzVQKLggKpSFFTBIvqF4e6TJsVbzVkLeCExdSuBR8sgF24j6ZQbuOuMKupLEAYr7K7Jx/f89LeUS0nokH80QslRMMO7Jv+gT8czSRXOdK5sf2XYOdjbOtowC/5NIWRWtUxPhSjViG8SSdNT+r4FkfgOHqaPcb/N5BHlLIlegiinm5iWbBjQEuRWAvwu9p2u3cxmo7SJCcyjE4FQfYDNBRbRS38n+gCYFtLMJ+2HbZ+jok0dTUavNcv7OoguyLqq9dSWQxY5erer7OW3MnYhaxDUHWUOYRIvyRBo5G7n1y
X-Microsoft-Antispam-PRVS: <SN1PR15MB0174EEB9729E4C50C739E5D8BE000@SN1PR15MB0174.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN1PR15MB0174;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0174;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(8936002)(97736004)(2351001)(76176011)(11346002)(106356001)(446003)(68736007)(2361001)(478600001)(105586002)(476003)(486006)(53936002)(52116002)(7696005)(55016002)(50466002)(25786009)(9686003)(39060400002)(1076002)(34206002)(86362001)(4326008)(81166006)(81156014)(6116002)(6246003)(47776003)(33656002)(8676002)(2906002)(345774005)(6666003)(6636002)(23726003)(305945005)(7736002)(16586007)(16526019)(58126008)(316002)(229853002)(5660300001)(386003)(52396003)(6506007)(46003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0174;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0174;23:/4vP2TGcH3nsBbKHwCWMExSUNoy6jLlStaIHLtI1T?=
 =?us-ascii?Q?EfuzFjyTR7z/NJDcLVbXcm/oF8SMID03ozR4sM/AamEI/FYxkYKGjh3maRkk?=
 =?us-ascii?Q?FhWmvjpnF30ysEKrqGrZfH94KPB4lCOKfrYUMlsVDOehEmkrnCs+PzD/2wdh?=
 =?us-ascii?Q?fmyp9qHDZ4lImEKhs17VvPeVawlgR3rIPcaT6+0R+0ozVQZD+PQtxBZVzIYj?=
 =?us-ascii?Q?2vPOLqW32yiqgLHVklaiVk9gvKluj5fAlOwbfGw58sRxSs8rBft1xSxVxcdS?=
 =?us-ascii?Q?zPT5DOqCYAtKdMZJy+LMU/mXxS7JhFD32fu/PNFLtSGR4rFecGtnQWM/xeTJ?=
 =?us-ascii?Q?LExuS4deqcdUwwKefBdwtUqj7OXcdVctZ7Cjf2jTRfRk7o2EfFyz8dfaFxqH?=
 =?us-ascii?Q?pDYfwtANor4vTKHKyC5QY4DN2XmLoZzZoDuz8+/SG0hRRAMOl9jyN30vXcqm?=
 =?us-ascii?Q?actRVphwvFyZUeP4TLyXvAp5eS+IlqB5Az89yDaTELem3exSSxzDimoZjEXO?=
 =?us-ascii?Q?NfO2F8iNrqE6/GPZW0LeNyInmoacTuPlKxiFqmHMFv05gOsCcdpG06647rL/?=
 =?us-ascii?Q?h1IymWAfhjgwOxWiC/7z9xl7+8Zt2oRVAaP1+VRdlQcBKgBz875953Z8icpp?=
 =?us-ascii?Q?uIeVdkbMXKJAJc8WFkQiNjBGDdNFjAh7agDrWwK5Wj6Fw8WmgHZSS/j6aKdx?=
 =?us-ascii?Q?EQswdJrZlXTvUhODC9jeE+OQnOoFrmPXgRLTkVzp4xXk5l5Y4iQep69GhWd8?=
 =?us-ascii?Q?F3tUz+gUFHFDP3Ygn+8SNVFOd5TLG1Zp+jNB3tjM6GRKL7JV6rJ9CmqWnrTi?=
 =?us-ascii?Q?QJsKbq1piOw97UOEZ6eBnwsb/ySoo7KFOCr4plJRiBkYwUfwl5utRSuC5R6l?=
 =?us-ascii?Q?VCK+V3tekRj8C4bwflbE8dWoR9lcGdNObmRjUhj5lgOSOnoIcrZJJDnVckDS?=
 =?us-ascii?Q?rmx8FW9Mv5i0BhF+7zcgWABWwqajD1R5TvnvxcgfwkWNOQ0pukF36VoVMmtN?=
 =?us-ascii?Q?Gv0cqPnXFx2aGITnGjikwf2H2ge6F9gFc3mSduzyEOle3XFHcK85YMlqMbWW?=
 =?us-ascii?Q?D5P7FPuz2WTOYIfJ7d1ZWLKLSx2KEiiUDFG/lg6XWloDgJKmKubJBnCtJzxV?=
 =?us-ascii?Q?OzQH7OvokfFpCAPDIVpaQysvvvHJQmRM6DK6BJYUHtIDkJweJ+vkDecbHRSv?=
 =?us-ascii?Q?/zZtG2TafkVcNgAb3TTW0PWHLR/a9zVYiAadS65AAfadgE9v32ABIwoC0rY2?=
 =?us-ascii?Q?ieFszr/pRDpz794SjwHqOnnXjPKuQg0MpcpaOieMZ5c9icDAX9l935b3jdYH?=
 =?us-ascii?Q?O7bu9Qg1ePztOT7/RTuS70=3D?=
X-Microsoft-Antispam-Message-Info: TWU6RFs73H1Ufj1kZEtrWoMBUKly9wqB4y3SboX3nfIk2p7nifo0I0wVNtzguz6/ERykIqcBZDGeOdO7qPbeqHMAcoF3C19CFZPY2Tk42Uh6q7/ik5a3t4Ha951n5FqNtmx6klEcR62rMTkK5HqZFA1MQOAlH6ApliewN/fO+k1vsI7UYSwphW/IkomHkSfWQxK/cs2tVveidPGfxeDlnBxz00NFuFN7/Hl6o/Wa4vVRyG6wmdIWrqTLmttBTBONudQSRsqNPmErcvQSTFO25my63QqRVS9QC0mhzZjJ630cJ0gWkbvW7LnIArd46rPs2s2AhuKlH8wpuJ4CEvs/g9GOd65fyEdwnSDdKgD1gdg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;6:xsFusMzRPnNreW+coVZ7JgVXDu/x1YE4PByxk7wq2wP1xTe+CC0+7SvkJ/cuL6cm7vipHbldVS5ARbPeFbTeJYYaiIASCHkv19ectSjw1S9QMhTBuimlFm7S7y8z8YS95n/wl8aI30+Ay3/GG9ieV/CGi2XKSC32j8IDSkCtc8VdAKN+BqrwCNfd0lycPbMs5N7dbMDm5ZRAr5gX/bk5aXGtlYVMzWbR2+S+Q85Of/oB9H2TTkky04FeVUu4PMMd6GljxHzFTUlNh876HBa72AYteotMEfx3m554+PJyPdYrgQPNEryTIHRvyjxXplE+blimdAJzx2u7Pd+8ZsNNyXqFC0usHu03AoVElKz4Unhem5fAgDjql4VOEfwrzS6lG61vIIAvEbSeyaUFteFxOIfiCh8DbRdDv51sG6FYIkas1xNaYRgvKJTx9472wouIfloGp5Trx3kRW3aHKhdt3w==;5:Q3pBiwT+Plz8rYQhx+JsuMU0sdavUcEihL57y4126WaSZJBA+w8DAWEIIxMJ/m2vyJB6rvU+3kTLXHPdgwJQiCW5yRXb2d65Ni/VODIzO30SZ6nQVgZ7ITHQ7JrfEmhKRjZsi2ZYZP5l+LZ6D9nlPasEvWIBEdrbY6mZkT6WGNw=;7:RvU0iwxHalKvbrGDtZPv+JrYF/cQSg7ws4Aoyo9iALnY/Zbeyf1d37Qx7BQq2Q+aN0SF/mek5ugJIfIZptRgPSSwD5EPW9Hm0CfYLRPwS7kFSI8v9Xj8jBq7SftV9L6eOzKF50mP9EZaeWMDLR1BZzFDgBUmO+XaD01hUTZ6bVmAuJ/og+XrZ8ehvSAjoOG34VCt7kWx30f4gy6Q+pbFkr4QEvyU4OBcexuz7sSQjZyOG/xNi2aXpmZUJfHVg0ym
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;20:8p0pNGHRU+zjydayd1HhFEjzmKkll/vKyBCaWl8k9Zr17DxlO4IMWEfsq2uWWykb0f6EWKkWIK6QH2Ej8dGGXXFzL7B5d7N0gSKfOPmaBk7LraMLPmadTAwVMQUoqV1agIz7lt52qo2yCYQdpC1iy5A1qqdFS4ahCeetDDvwB6o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:56:50.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4cec7a-0d02-4047-df85-08d614e2e822
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0174
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:49:23AM -0700, jgkamat@fb.com wrote:
> From: Jay Kamat <jgkamat@fb.com>
> 
> Fix a couple issues with cg_read_strcmp(), to improve correctness of
> cgroup tests
> - Fix cg_read_strcmp() always returning 0 for empty "needle" strings
> - Fix a memory leak in cg_read_strcmp()
> 
> Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")

Hi Jay!

Thank you for working on this!

Acked-by: Roman Gushchin <guro@fb.com>
