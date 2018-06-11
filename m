Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B8933C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EC2208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UU8S4OpB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RLvZp9Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EC2208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933821AbeFKRzA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:55:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932647AbeFKRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:54:57 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BHoDVn030612;
        Mon, 11 Jun 2018 10:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ACiJTyrdJzB4Iz1LunXdugjSkTm2zOxWXTC0whmSR3E=;
 b=UU8S4OpBTUD2jHCsjb7miXyZSuIkYOv7kFS/r652PMYDfYldkfXgKHTSWIHAVoSX7F+K
 93SzM914xB5cwqPan1iNNtOAgJELQl5E5DISVoRMO028mi8oLhjipQKJfop9XpUS83y9
 fjh/8+hcYeiSM14buty0mUYjdiGb1PbnU5E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jhvn4g8af-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 10:54:47 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 11 Jun 2018 13:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACiJTyrdJzB4Iz1LunXdugjSkTm2zOxWXTC0whmSR3E=;
 b=RLvZp9VvsaBsddHV0nwemzeH5P515xhvVduvbxCvne2qtqizUNfVIwAtk1MMaR18QeNG3Ix3pUYy8ce+DG1Qvn0sBiYZ6W6qgh0sqrPizhSZZb/SY5/F8OXYcI7fpVIzYO0zKpxktmmh6kywRt6RcSF/S2cSBlGOwEwomCTtKE8=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:49ec) by
 DM3PR15MB1083.namprd15.prod.outlook.com (2603:10b6:0:12::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 17:54:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/3] memory.min fixes/refinements
Date:   Mon, 11 Jun 2018 10:54:15 -0700
Message-ID: <20180611175418.7007-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:49ec]
X-ClientProxiedBy: MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:HISXwvCoh+zIsKthcD9AvElpe7qZ+6iWOIQwtXnqxcB415GIlR209kE/1tHjCnqXLAOaGIyBCx9QYlvnruExfA4v6nhps/dVtA5/eN8N6q0ChjYqO7kasP4v4D8cC6T8UWMr6u4sgHQ0usB7VKIO6UoEDZBwWeAjnBkswx0cPBd9waWoU5mNuhBcNfm75E9ryS4SYMn84ajXC9eZLwUpNjyOnICYwh8I6UM68Nk94H62+RLx9+2gWlj38jKq/+6n;25:lU9RaczR8QMzcF3FEaKQU2xuIvpxRBdgpoDxIca6oZYZK6TpGSvVnWNGaGdkT+iP64moZEHZKAn70ruFEbvzYKCGeVc6GOY5xGeoJYi+jPisrUc0rQhoFKSSTAiwcBBzoWDrnjxHvFkv67Qc826qGpZYYxZJq3Ji4mig/mGrjYUUmlIAHlvkMPhAFsVEjScL9qorE7TzPwxEYUhoC74gVBhnnhJNjvnNy9N7GSqLQnc2XS9GXlsc3pSLNxOH93BCHXRAxqy1sVP+Skc8iXUtuwtDTW0NiMTRoQyYHtPDk2zNvWF+7c3vCYKHRuXy4yJKnow7oCoI+qICIxy4subyHw==;31:SFQX+hMp2nHPoyT+FOWn5cyu6DXq55gLYdxxcVmaVMJbspYAmaFT81ZWSGorFQ1qN6S6zVB1XvYVm0xxR+tT8sDTYJOh0KNwOd/A9IJ0IpJvXHHPmscyO0WrCTlGkQOK7PdgnxUVBE9Ol9/B3CRmz/2K4wJPvZzBg1HTdXpoaN4qZURsgTCmDL+jeHegucnf0zYKBuYbfwC2+R8BSZMJJUzigsZutWl3ie/B80ee2u8=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:7Tun2GYyGq+3/+YYAvW6NZVkr6nq3S8fKx3zzID3asgnDP5pf2kyC6YWBgqzNJU770jp74ESQvb+XESXJkxtwUgS1rbjYOODKg0/79xX+XXe3xVJGSPFTn7EnciO8E/QsipaVU3SyqgjxHoncr5i1D5AHjd2c3L+I56gZ9nX6IfqQP3R1Fl+jrZAL+rBPWZzbseYH52AncfVeBTIzz/NgeKLTKMEA7bVaISMEQCG4hPOZhZ/Q36mAWjttJ2sVfoJ5m8d2dMrjKAubo1cv4Lsj0GNw/qx5NtV44YXPJD5w+nOr2ruIR/oHbhykvDr4I4aNZLqIVUbT9ydjtyTxCBghWcSGQ57QFRWRDBeuS5jJk+Ic98pt7U9O5N4IEcEyLPo8ls+Ww5W8EmDVD3Ij6xQwrAUBSaocje4IEE9Qxlfxqgq84mubxGXcq47+SIShDDTdxf6MGUw7J8fF9p29El/3lR/78Nbpruy4Ky2c5hXbM75VQelpDcfzvFYTitbMmhA;4:GVticPM601b1haSmxHtQlWE+NYWnD9X4z2WPY2VPjvgagrtJFNuqwnkGctoKY5BWm6CX7eLVLM3vZy7qiD+umIbQpwKYRMWqAvgGCEqEywK/IyRWPk2gkyxS/8ocWmNWaK3bnnkzJ48wjVGmrBxdOClmKSPm5bJhipCXRkC6C2/SD6GGLjo6u1z62ABPUwm2VbyHdr1JHtG2O/5NTRwBHcvmJebIWnlkVXkdK4DGCx98hrc83JtRgh/acRndMUcql/yf4yGHTGtzttljrbvnOg==
X-Microsoft-Antispam-PRVS: <DM3PR15MB108397BBF3FD45510BA8112DBE780@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(53416004)(25786009)(50466002)(68736007)(2906002)(6116002)(48376002)(6916009)(6666003)(1076002)(86362001)(50226002)(6512007)(53936002)(7736002)(305945005)(8936002)(81166006)(81156014)(4326008)(47776003)(97736004)(6506007)(46003)(105586002)(486006)(2616005)(476003)(106356001)(52396003)(52116002)(69596002)(5660300001)(8676002)(16526019)(186003)(386003)(54906003)(16586007)(478600001)(36756003)(6486002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1083;23:mStac/GVV87ka7D8i8l1xKRqjPfIeAZ3Au+BnhuZD?=
 =?us-ascii?Q?UxPsErXjzklrjhOOAn4IWSKe3crCiSfbfYSDSxumuG/gIHiOl3RB7C06TGrK?=
 =?us-ascii?Q?XOUJMnaJFHdN6xtYIhOYnm/xffFfPsHQG/23pJZMWdYAW3U9PiOjfWRnHkhW?=
 =?us-ascii?Q?xkfAJSUGUX9HU2ugCE7cH3cECWcRFDuiSZwsgd7aFMBT6Dhmi1JbWlKKlyDj?=
 =?us-ascii?Q?BJIgEnAiubQ0gkL6r9SUmJayDnI46id7G9cI52nke6MTP3Goe736ijDRQrh3?=
 =?us-ascii?Q?yUaTxSfIxEqxIJ7AoIF5cNXHyeEov7vM7pc5Zj7v4h+auyQ8/h4UpcH6/hw3?=
 =?us-ascii?Q?4QGbaIqkU4UYBAIC/CZ5TOkNBN+7RLJ9YGxPdrc3SOQyG3Pk8DXV+Qx2oKYg?=
 =?us-ascii?Q?wp8rZXAN/dEtAEIIzbV4lt4gLGvKekZ9NpIk2j7yuGkllE4oX4LHsKX6pUs3?=
 =?us-ascii?Q?dnA1Nhra2Y/e8cAahAcR3/NHFO0nurSvRldwxWsS+UXQm21cfu4boPxQ4kYi?=
 =?us-ascii?Q?IgVsc6DKSnX570z8QbRqf084sIGqaChsj9JcA8C0VSRr4l1uG0fhK3pel/eb?=
 =?us-ascii?Q?PIHP6NWybhNCbWCZgSVbCKqam+hPN4kKf4QgynTP7zmGKBDA1lgLomYxNQgR?=
 =?us-ascii?Q?rRuDdSzJ1tGnIqlulyYjYn2v7VSJttYTH3K0bm7hxwjT5xMVMvZtFD6aXN4y?=
 =?us-ascii?Q?2FG16ZtLRwgVefKjSqj8QHmS3qrpkSGS7iPofbNGKtMdEdzJjI+fM+rxXzHG?=
 =?us-ascii?Q?D0pWBP1yY6mp0y5ZeQruuKm4UlEj4aKpD/yekjbVoI+UAPpXp4TzQTAJbPE9?=
 =?us-ascii?Q?8OjhH8XexdznmmtMgz6AIkppLyJxUvovsX+MHZwCLpnMFpnRr1nJUaUnR9AZ?=
 =?us-ascii?Q?6/O0l978OTl37YKLHYwm296BmMX7EQ4M4e/kdxel0ARMSQqKJPPAGa8MJjRU?=
 =?us-ascii?Q?yXSF1kZJbnQvwJNyuhMejLmEORNorztmHsb3Nlm9sXJEzcTQbAciK+aX/cpC?=
 =?us-ascii?Q?Hr+JiDGE3cuc47FLiUBJfG7Pa7NUdavSuVDYgluqVQ44bFvXUnf3nUZVt+56?=
 =?us-ascii?Q?Rhv+2CjngAWSJgI9htlLyoknpLmU7vMvBes6lSm4Ud+mlkQ41jAoH7VtRKDn?=
 =?us-ascii?Q?N92IH/CdZDoRlru0qgxsUQ0WTVN3+Shr+PMmSzC3kklc0uBwBjn1tSaBo1jT?=
 =?us-ascii?Q?n4WPqBeMIdVJaY=3D?=
X-Microsoft-Antispam-Message-Info: 7SwQ2m9c0b9OddhCzJVmPIq7a4zlnIPUMF2bqegHhRt3at7eRaeFk9e9MfUAQnnMYUEJmgPPzCtzCWR94rR2MYvGjTdUqSpUkGZhFrUMvoSOrLmS0HY2SrFDMsvv/x49VpXZX3SI0QtlFjJxm1SaKXC/f2nhj6VDwzE1z/yM62UKxBZ8NmwSZJnPT1ZTZurn
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:udcRXIe13eEscvtDvYjkfX5TxYnoO4FsMkLcmeJH4+sInjEwUqMm2X5W0xUizCud2EmLcZhqfEKhkSdyZjsujtwJHGGF7F3t3PJMAyKtWhnpQ92V7znjPSMZaoA9kwxR7HZ3Zac+KhOu02mfZmOeU76NzasCfzymTISHofC6P6PJ/NOGoNSUBOr8fUSgV3envFaOOj3+dMYiDNVm1CoJY1PxEZLEwfzWIVw9NZ0TM2Fb+i60aRRsxoLH28DgK4zwedOSUdw+myz+vwGJ2/bM2ftZzNq8AxD0wO/rajH/QNmXsnF7LtJa3Q4ne6QANwmNy6aE3FRhDTsIYEjlsbPh83h/aud9diAnX7574WddxsgQ34tPoOtoj3tessPfIh2/+e9U8px7/d1w9Hvt/GRIthRvFtobzQn4OdSZE1qXj6lUP0Iu3cp1jyxHwyLA4duWMdqSNmJBnWcp+xPZNQMnsQ==;5:pYJ95DBGmqDLi0dAy7jBsLzIVSILgwtUMhcheJqRciekFlgmz1i8D1anYU1wNMekW2YeMnjJT/g5qt2hVsPKwACBjo+rMnBhX2T8PDE2M589JJnVPXVT+DYPiCTluGj0SOy/F+B7DLCvVsjk+t78onWL7uMLsrivjNiVwFrPC90=;24:xD6MewPmI6b9+kIcU/fezWR4GB+sdfE010Hs2BFBE+Uk3fweTWHmN9XuxOTRoEYcG/loiJ16QzVn3WH79oa3WQaDJlRv39Y4jFOkAbwppuI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:l1fsq2rKDvN/EuoKQJGRBRwjYpMqj4MLAxzP+T3lG8UxfoKE7ipdRs4mpGny4auiA/dNuCaGFnFH9LAAzEzqQkYyv7pRGVrVB7fgU/QPspY0/3r6Pl9Mwbcq4DQ43OA2ItfA3P9dX3DFFEugTF7vuHmYaYhyfqCNzD6IlL7TW1r9k1OTkid8IHvEaM9J0OCxsDqDkxBdweyB+FirCJ3y6rrSpiEHYZjIIgcvZYpYV8Olpl5tmjkzK1L34pgF8YW1;20:8fqJbqu1AqXcBPnwejIkPpIrTA6qGSXiC0Am3eqpcbde00J3U7Mmgp6h66cKLpj08crkgRUil+yq4IqRMZlzSxvmUD4ufecQYQ8AmeuHMews25wO4SAjpCtcrZed767tlm/bDYwNOb1yWazLpGSYmwJA3hRjcEhTRxwRTXHkJ2E=
X-MS-Office365-Filtering-Correlation-Id: 137f759f-90bb-4bf7-7b3c-08d5cfc46817
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:54:40.1145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f759f-90bb-4bf7-7b3c-08d5cfc46817
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew!

Please, find an updated version of memory.min refinements/fixes
in this patchset. It's against linus tree.
Please, merge these patches into 4.18.

Thanks!

Roman Gushchin (3):
  mm: fix null pointer dereference in mem_cgroup_protected
  mm, memcg: propagate memory effective protection on setting
    memory.min/low
  mm, memcg: don't skip memory guarantee calculations

 mm/memcontrol.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.14.4

