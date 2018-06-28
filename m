Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E759276EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BtuteRtq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gaQ4gC6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E759276EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030297AbeF1QvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935749AbeF1Qs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:27 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5Q013501;
        Thu, 28 Jun 2018 09:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Hsn1aP61WY5mi9caUh2vv9xRR+cwVrxtn9nVVxcjotg=;
 b=BtuteRtqRj+owOpmit0dh6//zk5+dcrkuYUzO7GRLZ5CqUF6fwxIuLmeqU+TqHObTHPC
 9YgUsChlQJkXFCuaU1w2hr2okluK6FZZnviESEc0Qf56hN1WUiS9cjV+ToyZt6zsoF2u
 8fVQAVCGgyskDEGv6jzlu+PsSoIukDujyU4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hsn1aP61WY5mi9caUh2vv9xRR+cwVrxtn9nVVxcjotg=;
 b=gaQ4gC6q/+mbzEwIWMtMG3lmkDp/pjqLzjshdn/nqIQAyZ7gc/qZ+HrSUnUF8dQ9N886ahIEJesOBOlhhkEjKuYwslfB3eeAJRXBz11uZ8I24zFWEWHpaVzjJBy7To/T82ItzL7eGNecVjHoc1DoOOeuTmmGIhPD6AE2Bg+Yc3g=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:47:55 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Thu, 28 Jun 2018 09:47:06 -0700
Message-ID: <20180628164719.28215-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 756120de-7245-4b79-83bd-08d5dd16e63f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:BgFfXkYtt4i8uhzl9chthspDJ3fdCHgSeX+nBd9EaKB7IhPIguE+iwMSoYvqgOujcOpULLYblTe6mTs9eG9ocdNiaBVOQYFDXVVpMB4rdJR1J4Ue+ARKkTYUDxtaSfFlp7OwG4ErgdgqUo2ZC2kVrpM8roJR37m6jrRrq0En4hlCEXScHVFf59U65ZtL/B1qIlfLyChk9jRwDHfEy8EAxq6X+rAtriFWXSomWZoSca74CJXbjV0tIQsKxmfi2EHw;25:GHBxv0nRraXsDKFOslEU25YDpI2spAd+RezOFwbhUYFgWcmcHMRUzORhV1wN60wv2AoKYI+G6jRI+ELaGwwsPttsoxNxdEXUXv8LsxZ81wgZWmmCZK0SPEUStYD48aWJBkh9mBdA73Dw0WncwLn3JfxDJYKeQod0/QU4Y5vgyg1/zrppQNtFaOjrwqIlvmYV5LmsmHxTHC4cyYmgeeUFX6jogvpAKDDZKwOWerZf6DudW3zORXmA97GMIEneuOkGce8dfc8ZewW5dgYNoe2v/dKpdBJj7ZNRW6cn6JBwhsdOLdJpuoD8MY3fUGzP3q5qmiS1Ggx7mjVOpRmkQo/+LA==;31:+iXTGZCVHbKKhkJIiFdyCd8i70+4haS3t2xVkIc+dw6ooJaikXJzHn8yMyqmGvfHJUA1yUVgLfQR5dwoECdyEvM7sqETfoeyRIPOHKqO1/6zWFzgd1It4cYfdiTjUST43bLNh2cS4u1bXX4/sbBqp1ca5jixtXVDf3VqFgtanblu1pqCinQBHKpcxfpnnCWVVKvAj+cZnY7AqUfvJ6WNLPlUkLQQdswLJ5WrOKH7mjo=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:50SsUWgEx4jTxyOZH6PQG0mYmAz02OKXyv9RHytgLlEUeOQk5RFcJjry2+V+AyZeAyeX5iWyFn80C1nqMinlsl+HHjMaanUBcmeyCDJ780nSoso+SiqIXGBmRlL2VuBZvUX1Q5BKLTBGPSIfgABQ8suO809jXWYY1Lh24dvyX7bq+56j8cNwyV0XBsAni5hIp1Q7gaGGHhnAgk/D9jLkFY4uF9qZpBqE4DDr10Kc9KIKhKMZQfay7z76lAqftsgQ4QmeyvDr0FvlIvMilvB28EI/hM/g3Qbne0iYQRtOfY37Nk3ThmNaG826mq4mNhZ3ZkHu59ZBKlSgB7tMTg/gNTulKOEvEO32T+DnO9UTn//H+YjX0p3UCo3GZ9pGysOnDSCRdmmYBadihF3+GHwpuyzo7RSuVPAEnv7LfJ2Q+DUiMK1/7v3WsKrSNc41bbXISgcLefAEin+/CsFiWW5RIlC0DcbBBCNVeHbdGJ2ZsoZUcAqRdajkP2g9Bkp44eQX;4:ppreAnyYt6rzSFunkr6DMYYITjQPvPB8i86IjawWjExGBgwJ2eyP4RCMqR3kRV236AKbXBW3c/XpFBoTdYk9YcHdm3P3IPIDuc53VYIq4oTPnPdRiwpTFZyq5GGn13zxqy7TZ2/gmPhodd7pGrOGysLYYVZ32UVbadHJdEQz4PGxwCIa6MFVXLtUvMo+7Hns4BnGAcXbpk8xQRQl3cn1n/jpo2gGe74tu9McdiD8XZUf5eD6qaGQ4piKKvv3GmV748sb77dQF/2/KRgzzJKXUfPzQBzajqA8Xjf/Z4+Si3gRw2o70o7/Lp2UOU7OaAIsennuvi3hx2Cjy9/65XwBw5jDAknczg2DDjZLWGbW/YU=
X-Microsoft-Antispam-PRVS: <DM3PR15MB10812B87A15A9E519DD2FE87BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:X9priZlpVy26jgXHt7/tcFzkKcyr5fjHo7cagKROR?=
 =?us-ascii?Q?etj9H162XM5tobZ/TepTvp4AJ24PZAzrf5ft696VctLXfAcJ1CwzR+EeVN0T?=
 =?us-ascii?Q?A3UTCFcnbbAVMJM2M8LldhzrbYB+46N6RjhwJZIW9X7/kbK54/H3WaEWpBJw?=
 =?us-ascii?Q?DJkwG5pkaGyiXfMNKSGiBZhkgcRVWrmAobFwKtDjH6AYret5AnNIFsVps3TO?=
 =?us-ascii?Q?GdSXBh85KxkOl3Ww++F8EsyDU+qsQ8MiV7HLuL9BychBtKtu6EOwJNlE9/ME?=
 =?us-ascii?Q?jPgBcoRGfT9Zs2322skPSiFQYu63/g/88lUOUvF3bYtzY5ZIm4GjmblTjv13?=
 =?us-ascii?Q?qE1E6ZcRpaCoiBGBTr/qxQtsNuNIWMOldTyCosmEiRiWdQZGCF0weFV1KWyj?=
 =?us-ascii?Q?q6FQnyOro75JRsschlu8+H7q3o9WUmh6sLTeuryhyhMI+eIOhu0ydg2oL7L9?=
 =?us-ascii?Q?OGlk0/Tw2NEeC1x2QveNqj30iflXbNwbga7OkO1B9XfFw7skDq65AxX+vG3N?=
 =?us-ascii?Q?nzIFkdlRokGrvqYNqiUxyq9l2VnErAEHWXYwjxNU1NWDEhEkKQu29IcSwyCj?=
 =?us-ascii?Q?gLJtJ5eYyRQqqLWAm9qrLRALBnQ3sBwIcw4kMc2GNs6+U5yvPP60MYI7+onB?=
 =?us-ascii?Q?ffGgj0m66j/SlbvTuLqJs6mhxp3TUZSw+84SZ9EpcriO8Oy4oaJSfFu2fQ3A?=
 =?us-ascii?Q?cKB/QQw4I89yKzDcw81Oe1AjtYUm1hmtNxPtRfQxWRJE/z2q6TE3iVhaCA8H?=
 =?us-ascii?Q?Ca+ff9+NvcezGZw/iSUSSg42wJr8W8OXp05jN65MnvSaitYuaMr4Qgwr6//5?=
 =?us-ascii?Q?QxXi2rf5T4vZ9cUEWKSu9R1oQTSW0Z9SKDAI09FIy9yzaDHo7Al9vYSNf9is?=
 =?us-ascii?Q?xrmWk0eaeIT6adRguSNIjgYo3oAkRKOiIy5YUkpLTEUgjsyB8QOhexKJiAGF?=
 =?us-ascii?Q?6/S2NfbzLv8AWOWkdzi5i6/xITEf/0+xSAbpOYjPfZW3bfIPx9sAeeXCZ6/e?=
 =?us-ascii?Q?tsKMPV5In76lsOmDkgk4OeTJyZ7rUAaYl3lVQS9iUurP5kIu/gT8YjPBByxM?=
 =?us-ascii?Q?Vw5zWokMCUEI48F/P0sYgBgwvp97UivmDQH9Z6tLemxruRxiHT1puO5NZtu+?=
 =?us-ascii?Q?29ja8gmkVE9V9VG3OLxJr6shz6XjQAAl44h7IhxFa9shMFjenj9ARHv6du8j?=
 =?us-ascii?Q?cI+iYPrDCisORy1ZIs9Ut2qGUYk8AAj48qZZz/K88fDyy6MMAdnB8H5yXANc?=
 =?us-ascii?Q?Qq/E83m88q7INIqQFEeP4ZdaTBhAa5lNDaceqJrGgXKFoWRuYY+VVvQPEe7Z?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: YBitIlHHdO+jMfs3A+88xSXbfXkT1VtqvBHGA+nvNlNlI2xbcdu0Ca9Q02zcBj5qaNHnWh0kn/z/1eqCZVx9SdyDtOxqbKV7EJoVKMxRc65Uey5qLuAvRRZyjkEs6mjCW2IAbKMX2xiI4GerldxYhoOLqqI91mmca7HAQeHe40SQk9BcAWBH/44UZeNBl0H7vbi43v1Adi1WF2q7n4u6eP9pWot18hwlc+TBT0AAJ59nsy0lxi0q8WVOwsaXOJXJ9b/0O2iYRlcrdsosfavPENZrJum71N9pweV31QRX59/oGjg1xcG4QvHQTpNRvVbi8+piByNnpdeoRE2v+eJ1P0ArIoUPRcQ9U4HoY/6M23c=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:aVgHCTaWCxqTnItuwSnflKVritZ4pshWA7puu2c7zv+MwqHCJaOB3v+KBON0bh0bs1E5c53XjWt2l4hhqi0KhYJp8I18srhIG6VXUA47EQGQGBqZ00/hAQIFDPTSfz3plIX5z94f/ckl+C78dabkX1ddQ/6lzeP6/uEyIXx8RWC87C7wbHglegWT0Mbc1I3H3f5FZ1PocRVh22JClHB2eLe4JSAh/FgB6tEBHNjpnaH3Dt2fwnhtpJOIC+wmJN7UAyLQ4ekLEqRfjWPWN6ikVYyj+7spNjOrdnxAdjEg03lWygQVPJO63diRlfvH5pc08gLE+AIQ8jmcZdCl+gm/FAC/uq8m3OXuPl/DweBvDhGuvxZF3V2UoxjMwmqOCvhSsyRXnVEGIa3/mdkK8jQivYkJMCNxrlVOsa0niWfVI8Un2Q+aoPafQVXpQjUKueyUD/ycjI2zmZuKgVzpNDZXsA==;5:eaKveCUpdHqN5geOqlOnBODb3aFD/rABMTN6YraZEyEL84W+NZyqHoaaYwAmpls7d3MrCFZUTe2qTGUgEhqLO0w6rBErhb+5E5koBPoKRwPi7miSgSKFusX2PlOD8cBYkdVqKPH9zjq/yZJKz5sxVfPStDVvzc/Zjk1+4KVUQC8=;24:q82k/smp+nUbLeCDU3Fg7kvlFUbKy74x+ue32ROuTyxTCXS1VOaymoVo5WgDRwQp/hBoBgeLlt1RFW9VdK1Ui7sG6WSImpKUfuJ6dnpw+LM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:Rys5JHpN/goBN2EdLv86es0xKr8OyUbjrcLmg0bMVw4CaJ+OdcfEqKiJqbCFnAGn8Epwvo8XRW9Se8R/t2WlXhvykr19AlDky2JxNuH8kintK3Ag8fD4ELa6kWkjUBg2CQuU03T+H4I3JxD5YAHWBQeO9VStxlsp51YbJmNAtOk0Pu0hb4ZH2wwFsvUxl6RXGVobwPe65dtJP7I0EjVCdDOaEj0vG8PhtzPAc0BopoIAEf+rEpO45OlEVm+QBHFv;20:OIWz4ofmU/BzELpiE1ldgHq5utnBx5nft1JACsqHjOD6z4pEjoUX0TLaPi8f61PM6hZ+z3q4EKYzZPHgKqeAkV+JgSJmnEoyRkaOxsxmyiC7TxwazHIpMqd5AI61Xut/C61UbcudEHU10WYq+Fz7E7KZMhRIFy85mZ8G4hgs+jU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:47:55.7390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756120de-7245-4b79-83bd-08d5dd16e63f
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

This commits extends existing bpf maps memory charging API
to support dynamic charging/uncharging.

This is required to account memory used by maps,
if all entries are created dynamically after
the map initialization.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 53 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7df32a3200f7..e4d684ce3f5e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -434,6 +434,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_precharge_memlock(u32 pages);
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35dc466641f2..e03aeeec01e0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,55 @@ int bpf_map_precharge_memlock(u32 pages)
 	return 0;
 }
 
-static int bpf_map_charge_memlock(struct bpf_map *map)
+static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
-	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit;
+	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
+		atomic_long_sub(pages, &user->locked_vm);
+		return -EPERM;
+	}
+	return 0;
+}
 
-	atomic_long_add(map->pages, &user->locked_vm);
+static int bpf_map_init_memlock(struct bpf_map *map)
+{
+	struct user_struct *user = get_current_user();
+	int ret;
 
-	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
-		atomic_long_sub(map->pages, &user->locked_vm);
+	ret = bpf_charge_memlock(user, map->pages);
+	if (ret) {
 		free_uid(user);
-		return -EPERM;
+		return ret;
 	}
 	map->user = user;
-	return 0;
+	return ret;
 }
 
-static void bpf_map_uncharge_memlock(struct bpf_map *map)
+static void bpf_map_release_memlock(struct bpf_map *map)
 {
 	struct user_struct *user = map->user;
-
-	atomic_long_sub(map->pages, &user->locked_vm);
+	atomic_long_sub(map->pages, &map->user->locked_vm);
 	free_uid(user);
 }
 
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
+{
+	int ret;
+
+	ret = bpf_charge_memlock(map->user, pages);
+	if (ret)
+		return ret;
+	map->pages += pages;
+	return ret;
+}
+
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
+{
+	atomic_long_sub(pages, &map->user->locked_vm);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +279,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +515,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +538,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

