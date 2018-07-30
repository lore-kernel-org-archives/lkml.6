Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E07FC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E1205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Rc1Qa18c";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="emb5oZkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761E1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbeG3TiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:38:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52380 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730671AbeG3TiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:38:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UHouvi010810;
        Mon, 30 Jul 2018 11:01:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=scuHpibUn0Le6Cs82Dm7fG+4MYqegz3zxv5qDEXXdWM=;
 b=Rc1Qa18c+u7rB6jpduVm02w1pAa0wVN34GXkWkVCyloTP2pWIt23vZOpPIe8yps/CLp7
 p5zdtxOjyqcHF6Xq/v41ukISEkKIrvwmQpfn3Giq3ulqV0xEXACPf3uWEpVWG4fRzl6P
 wajjwhpzn/nWyYR1AifbiJvxZV/m9Z83jM0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kj53g0ghv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Jul 2018 11:01:31 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 30 Jul 2018 14:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scuHpibUn0Le6Cs82Dm7fG+4MYqegz3zxv5qDEXXdWM=;
 b=emb5oZkByn82N4+xxB5IU2w8U82y+506VVFjXZsv8lW8biYBbyfz+4dZTXq3ILdB1e9srjfUBh80JJHBZX+MUbXRISA6Xtsxje2N+9N/HTpItfoyJsj60bkubpcAqrT8wGWe8hMqt7IGUidNQchkAYf0n3urxrSutCaQrCtDqV0=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:484b) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Mon, 30 Jul
 2018 18:01:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/3] mm: introduce mem_cgroup_put() helper
Date:   Mon, 30 Jul 2018 11:00:58 -0700
Message-ID: <20180730180100.25079-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730180100.25079-1-guro@fb.com>
References: <20180730180100.25079-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:484b]
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa46cf4-b16b-41ec-0512-08d5f64678a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:EObc8fDgTFaQTwI25z0yY9fuqYoJfJFPjuU/eDG8GHgIuSMJJ2qGgIwugF2VD9LwjoTyzPTgv026rJ1SyYp12d1jCwDpA4Q3dqrLcLLGvgPcydlvDQ4jQQ4NEHVrCzaruavRWot8Mf81Ib/hX4E+TmlYwNdrSomNqgQAVXGvhdGYbeMhlrS5vvLyl+OZ6URm+pPluiLbztMRYeF3q2jPtkeIw8TjCotwUODbY912sYh1nWi7vlc/9OsFsP2U0MH2;25:EvHC8W7QxeujOCQRK7Z6JtPCszhR0XOjET2jQfMxvpil14yh1YP8n6mbMQs1KyL/Nr+cFhupnPfKURl1syevYD1gftNgMgOeByZ5Q4I1fdirHjtelCWS327RGWqzcBzVFA5ByD/n2EOMPEfM/TQ8EG7fSsI6oagJtbdA3GscHljpNLGj0o4PhGSjg40+EPbSMcIMmmi2q5DD8LeB/W8NtMsOx9LMRWOIbNutMlj2Y/YVIac6ZiEvHlzmv7c0RpS4D7I/H5jebXhXfDgYsbMUkReiabILhc4AL58JFjDarmr5k0GMROCLGDCuj6NBzTcQWHfaUEE2WsgKHJPD/EgXBw==;31:ijRt+ZPS7mrgStyYqIWCr7NtYyoicQgsAxZ5/przYHz0JNwUQjW6sGkQd3FyVoNEEwtF/QXDeYcTXwxE9rYGkCRz/YhxijSdwwQQpG/5i0Es/29fdBGtZ34tuW5/0IRw2zAmDTTG2Pk06o8rmdpyx8wtgB6/v1zOG/e88LgQ1C7PQwHzZSmyeXfvsRoF8+hKPdju1seHj9yGGpDucbEy638Od9bQV5oklJRthkVWmdE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:2929LKuKKlVya0Ok7L8rlviLBtZw6cl68/zpoCHIQw3FLQh3EvLEPdX5ELegIpocJlVJy9r9OplqIrSuFthTye2kivrZHZGF50JiDKiOgN1muZR6sj93eRk4V2K+agjMkF9qyJ9bInEPDptLwVQgujJNOtSpOcaw/JF5sVkdgRxkt1xgph+v3wWokuj9eGuU/8N/Wqrr5u0J9NQGoQDa7Fyy1FPwLRTCl4QIwwdA+U/46fzuw2sIZYeEE+a0TG14Ay/ar+uMqT1qEV0MOgnet21kXnJ43meytRn9WXxEwS8YGcHegyN4SejWF116RCk16m8huLcjb77/zgesMFqR1tjDMypUzxIemA/2thMpx0PQwQ/hYRyzDQ8Lvd3mb6riCOILDJADo4i4Vd6OjZ+6X4capP1ZaZNG7yBJI5cFRDq/tzKsHsnCRSmdfVnu/cu/CatNWzztY4Zapb9xXw7A1pEyx8JyQGjyzLokOGtcxHA92IRODGulLsEbaX3/eMQP;4:7mCi/p7fMijYgC/i/WNzLfiAMpSqdvzkKRCFVcAK1Ys/xk42bTFJC83qJLXyRTMnZHIEl22SvaFfWpEgAsH3sktXYuIcuz50YBmMGByh3bEYnnmXJ7tAUVjVlS6BmARbVwe8Mc3gFk04+RaU78CcP02a7jTEbdpYOOTejJ5W5GCqZeaz6VKI64OGuLJAwSgmK6hqbaD2pgnbhV9BbL43Ro6s0ibbrAyPknh21Fg4W88HOwONE/ZEd3Pzxf8ARqSARM57kx/wQ1fsT/5pExIA3tmJ48B4ALUNWqcsjJBzNS/sv6K3WR+1tVe9DHBl1kyCgUkdL93CsboxlRtSPMoPO0QwoHd3kzuWdYBuRNWJ8WnEK94/2SwpU/fGMbyn3ZF9nCZy+px6Gm48BRzsP3rSs6JXlLz29vRVatTTVUQ4hcM=
X-Microsoft-Antispam-PRVS: <SN1PR15MB017515D410E36560752F22D1BE2F0@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(36756003)(6116002)(8676002)(6486002)(16526019)(6506007)(386003)(186003)(1076002)(86362001)(69596002)(76176011)(52116002)(51416003)(52396003)(81156014)(106356001)(966005)(2351001)(105586002)(97736004)(8936002)(81166006)(305945005)(7736002)(53936002)(6666003)(50226002)(25786009)(53416004)(478600001)(6512007)(6306002)(7416002)(5660300001)(2906002)(6916009)(54906003)(2361001)(16586007)(316002)(11346002)(446003)(48376002)(50466002)(47776003)(476003)(4326008)(46003)(68736007)(2616005)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:amZL3cxWKSlIupBBdSWTHL2RrzFAvwVWfLi4okpZJ?=
 =?us-ascii?Q?l5eqBTshKVx5ycizY/dNIPj82G6PwiBLHo22eYAEeqHGOa3Hyg5f/cMkpnG3?=
 =?us-ascii?Q?yxJAAPaHh1ZATnTDm9ndNl2uCVAolBSDxXsLdKsL7gM+4UgfP7M6pkblDa23?=
 =?us-ascii?Q?tc/vKDxV/MRdCpUB0VKRCwCMt3zHJty40IWIzurzmZxq+Mp2JAbPG4JtAaSA?=
 =?us-ascii?Q?rFlTtFxJmAOMoTF2mewOXibu7bCIern49QKryqsKNcmrL2nFZ2NK2xdolhBO?=
 =?us-ascii?Q?yLugsl1gBlngv5sv0+fCpurataZJyiVdyE8hm4960eW/RSxbFa6smEBikiyS?=
 =?us-ascii?Q?5Qx0nXZgBDAPmNj/yym62iy7KKG7lxN9VPMlOZmqDA4+olfvcNWjPObixdfl?=
 =?us-ascii?Q?xT4BriGzHVYdLVhPCr7L7BanqHP1PKLy8Bzk/l8nU2TCkQM9vKpYHy4W7xXs?=
 =?us-ascii?Q?8aPkYe9JxXiXPq0nf2x38tJg3F2GjdFVCptIxyIy1DVJSG6fHvRh2WJckmkN?=
 =?us-ascii?Q?H/GNjPRjhm7cRawltqtf8MW1YVJyFmdM62BcUmWE8FyAZr3titwa2zHk0HDX?=
 =?us-ascii?Q?0gNhhMZ1xBwtaYl/5Bky8wYs7+oZRCzcpl3GmtSV54EY47EUn71OQah2E5vP?=
 =?us-ascii?Q?ltMRHyi9+ZntNNLKP/KKAIZsKSLmB3mQyyjmWd4bQJL6/T1EvEBdsWmgtIu3?=
 =?us-ascii?Q?94RQUOkNJDPHTLAAB2IDPtEEexd07AkZaihUl6R1yTYv4VezRjvruJed8qG5?=
 =?us-ascii?Q?Bu5+J6dOtOPh8tc+VaIqDVySpt1JJMGATzgf1kgnEf8gJkamuLZcmrVeHxRp?=
 =?us-ascii?Q?X6elMk0PHBF8U6lWLT/g4bnP+BTF4njV69vNVH20nhBpYa89EGkjg0NKfaQ1?=
 =?us-ascii?Q?dSuOsRX5sH01EeVE40JDZS53HTJg/6m2/ttCGLhwubxGIYRGOaUhZ4wUKrLV?=
 =?us-ascii?Q?rY2IUY7Oe9evfX6nQPAz04LXhpauCe58P1D/zvz+QG5lLLaXedb9/GaZj21B?=
 =?us-ascii?Q?u5Uu+zdlPYEfeHt/ZjQzrU0trASMfEsqwbyfiJzcTRxgEAHmrh7p/7H/o/F2?=
 =?us-ascii?Q?f8pwonxYHZqxNTgwlLIgFOV0BzlH7J2SKHZyILJUZNxFSj1/fi4OvHjcYqXn?=
 =?us-ascii?Q?OFtobBBpUgc9dDmxYrZ2XeWWlETT5fw/KCrMxFk3HFITXUxTj5fqrElq3+dB?=
 =?us-ascii?Q?gsorpCGSF8cq2Y57iOoXmFABcdL0ZCesDrQiqOB7CueSjzhlkKfHr/SJVuwm?=
 =?us-ascii?Q?/HndsbibtrC6TJD7g54Ep0UDzEDfPJEwtZlk/8lg55eNqHC3xdoVliWd2adi?=
 =?us-ascii?Q?1ZCsHwcnM76Z14vImSclh6YGje4fkd+n5BSQRrGPNVz?=
X-Microsoft-Antispam-Message-Info: 0ehppQeo8NQlx820+Lv9K+xusgw9o7GqbI/qlO322ScTMJDgIC92Flxm/UNgySg5zNcYqwE3bZksTBgZ+SOO2mtSlaE3ZQH8vZj7HRlUhgdSAgAtlGygeThgypSwBv4PFTL4230EtB/re7AhDXPgM/32FP5oOlnxmBCst2dHIjlENighnF9iBs+WMgdOd6Vvo3n2+q+5sc+4G68BuoNDV3egA6S60ek9/ahtw+9H86BOM0a0xEq46SVgK8WFIHYuiE8b5b2a47HJnwotG+tcGS6k9HVfmAQOCXPhyUXGJW3Q1OvEe2Ri8hHHLl6oFsNnyY7t8Rf/oIRy80sUFM/BSeUI/pfIDQ0PexGqVWwmv88=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:aAV7IgBX9gmewPA9LKqHOaXRCtPpWFenbAEWJgc6zkxkMAwzTbxV+zX7of0b0qx9eaS8cGvjAX1q9xP5q/7vS3OJ8fn90XK91/fcr5x5Vh6G/wg0+fyP3TCwPRXBMD+500cZetBxzT9M4kM1+a18cLbtwCpr1JQLeeCro/3XVEMukAu3fMKyFIu2APOksbcLf6GH+WlXp0Q9nIsMZWq/AYzvAkQbRehfTOSaBm7p/0mCqb5C7Q9HiYn/3u+vxHp3jt77LuR2I9T77prSYvUdJ7ZT2EX/81SUbN1gYKee8EUOnvfW2833Fyk7tkt7BG5YV4NaFiiCyiiyUFa2GIa/qJWssq9ReisdK6HWgJuF3ysfuLET7mLnFzXq3+xC7qCPFfRSrfXZ2yp9Z/wUCodSMwAyHWhE9lGXEawBSQigz6YAy2kYXjm9zc5R1lNtGVAasQg8BgIB6QaY43/dDhAu6w==;5:CBODIOzb7s3HAbRe/JSY/a1i/MdGFl/xIqEFW4lqPIV92E/rJkiem1hG/+BJA//pDClFukaNMkttIpmYZ6ZQDQPYxyJVTsGGZn/2TrTmuUgRCPDSbp9D83eLad9+qIvZE2KFk+62mMWHRRtiCVYLx5VQq/3KicYA+3IarZ8sEOE=;7:xlZ1mJI/vtMefMcDsHnjv0LaTaX9nYEaInzgEzKRAtGhOf9M+ukfufeGGmuFAgk8TY+w4dRzA6pkNi+sN+g64hrPBPrOqrtO+RIwdWHTijw4yhYOwKpLVqgrsq45UWg/EQawFJ2RZW4eZpFTFhvZWldQy0iy3G82xjaKJax8DNac9rKXYgDt0dBhj8Ro0QDWY5UT9x5HOx3EaQprb3IR8OS3OYseBM3EruZNDzAKgCTLpIoF5HnIulyUbKDnuolb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:OrJCI7dNYq/HVyx0lRpuVBVZc3QjxYOgyZ6ENZfHLIgdEVPWDFpzOGIE4+xurt3ykLTvIJ5Mf5eZYtmGxpt5lkuHzI1W85bBjEJEGWFQe0YPYYvpJ4eTfdZYySoHlgzFMnFhRzmjEa0aPHHITLEtgtbx/eyXVpckuj2pyIlUss8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 18:01:24.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa46cf4-b16b-41ec-0512-08d5f64678a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.

Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/memcontrol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..e53e00cdbe3f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -375,6 +375,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -837,6 +842,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
 	return true;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
-- 
2.14.4

