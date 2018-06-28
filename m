Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913A3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C18276E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mwD/qw2L";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L+eSjjd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C18276E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030356AbeF1Qv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935742AbeF1Qs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5T013501;
        Thu, 28 Jun 2018 09:48:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+qOOqQAPe0vgM8Zx+Fwoa98C+Ak2xOjkSvLc9iryqjk=;
 b=mwD/qw2LAbe7pa2DrQ6rhJeaJ3Al+TD4tqpG2eYCLflaqgWDrXtXnFtf5TQFmiBOXDAY
 v3nFIS1D8M2nz2o7wT77RO9Jqf+XlUinxr8tei5iPMQVbMp7KPW1+oP5rRGaLj4OfSLT
 iSuuflNZXMAj4JKBwl7ahkk79iOI66Xs3yU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qOOqQAPe0vgM8Zx+Fwoa98C+Ak2xOjkSvLc9iryqjk=;
 b=L+eSjjd3PFZSeFBLTJ03ZsYGdRIoMh4NB4O5aa0cj8YRHmP+hEuPXWLQWtRs0gKsE3rBbK5Mtbx6zogxCrKcMSszZL3qLDxitB454Om25ypV5loZhEkI2o4EkD84CxfCfoCFzpK1rWMADPg5M3JxgJXdb1IDCvC1yHcApgneDyw=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:47:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Thu, 28 Jun 2018 09:47:09 -0700
Message-ID: <20180628164719.28215-5-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19b80064-dd7c-477c-fb98-08d5dd16e838
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:VghcPEQMw+Ov3M1OfHUbGdIk0xA0uHuRVzaAajo6MeHInNykZe8qgaW7+YyxUKXro/DPhZqLTPkZKvn/NMqovnpxcanWY/45bJaeQUkW3b7wXAKIEbF1FJBhWTuw3lIWaDPbnwKT0tGnPLnCrLy/JnYD+ObFbNvvFAPPSymKFI2xYINRRRKPbY7y2MKS5RTd0nvliE3vn+n69jG4QTdVbATXAZzGBXkZza07El0NfiHDoWcOZYvc4T7d2z0Sh47/;25:F5Yc66/hz/QKOxK/81NY9u/h2v3NvWuKw7WtNema3KAygXb7+CiQH/pQFA3vkUgXr3go/CmmMDF4IpPh8S/cvMJDeYqfhhfUFkwHVz3l2uv64q00duXLcFpGXlPaOTt5wMh4/B8kChfhNoy/WTIJ4llYrkJ14YRJJyFSVbKTjGWkaTSPfb2zZwKrtStH3DmxgkKgtljedZsvUefknpj8mF1g+quZ2jYE8DqJW9TDNC+33TeRzWbXh3XcJ9t+nS2zLB1C+5XWkCcvfPNK7au8S4vz+uWWTonBTxyYnLajoJLzRS/Kjbday+4Lu30OLuvaW9d/CFzx/RuowxKcCE8ZcA==;31:Ns6SWU+aNuMzCOsuZkWjzsIZkl4LrpA5H7kbX3SD4YjRDhlXaOwqWc5Aum8tDe6JQJ1CZhODY1Wvsp8puvvD+prZsT5vai1l4aUd/hmgImvkoBN3Lgg8X1VFvycaTiRM8MKr/mKuamgw+5M/749kwNB+m3AiLttgWmyohslHZ4CnjxdP8exSD9Bvz3x0ZTWtNQeggZhd9FS05ajjWsPVEbbv8XgK2WSE43n2105TaLE=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:I7g/oCPxocZcMwVFXpr034CXMym+0Fofs1XKvBUq7WFoNuLl+0ldAlW+xwNoo9vkUWEGcIZ9M20E89xmKqd9j46ME6pByl8zvWU7O5857guTnIjedwMryr/+Y4EBdzcPvXPd9pFokmeX7uwnS+nkaBXwVotVwFiE+iDycaQP313lw32kwVEQBvkJ4gcjylM/foqC7dpzOoSUn+2YlQ+aB+MMQLztqfTuCkIZtCgXxkGw3i3HVc49gl9mZCWiK1PlZzEzJ6MOpvpuJjrAuH1lv1D9LvY5Ydhx5mAH5Vb+2GYFo7IQouPxGkwawQcJxEjAeP6MAiZ+jeu2KsNCr/O1emV/PFAbpb4DloHbj9++8r2nIluZCBQSMX3hbX8nLE1LCMBMpVIUOKrbrBF+sNRfmFw1zNyrQIMI3oMXwHtt4awF0nhg3teTP/a7E598oNAkyiOm5Sq3hSPN9EzhXcgwY8vKRXQgNuW7mCPWWd3yJcKeAJrjD3EmnRMGinn43cwX;4:vMtZJXJnLMBomphLcO9Ya7D0HqtpNaHdsBP6Db5lY+tsQZwGnb2Za+HTxuiBag4udEI8zun3hyqEpEoDEv5DpsBbFydYKDbVzRKdextGtZftP/1il3RNO35SZYews7ntr2ro6KIMPfoIEbXYC5/XMOsynn5BpvHm9r4JCgOkZnR3ACPSjDBiuov0hmj6K3PXacTrsK7vbrZM1IsfHMkqz33tB+eOvpfO/MFEjFi4Vi2VIBDwZQ7h6RPNupowOotvIbJSC0Zkl+sVmlaF2SIy4+g6VvEbrT89HcH5AE73fEOgCld/mc90tTk+QgDZD3JM
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081E8C4A5E9AB487A86F665BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(575784001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:1Naj+UsApc7mVb7fzCDrgolnDxhaUpBNvLDpLIdz0?=
 =?us-ascii?Q?+1YgNmMynaS6cmjS7rEbXs5F7drT71VIu/d965JjFHjJicszvkQvrH/h/Ks9?=
 =?us-ascii?Q?Hoy8J5t6gdHyi8oafaEnm7tEDtPDP4f8lX6L6VniVmT/YHYvXbmYUrJEVnAA?=
 =?us-ascii?Q?hOA6lvpJETNV9NV9prCK7wle0dRbaG86xw5o0Xj8FbFgHjFIJ6PEj/w2VKKI?=
 =?us-ascii?Q?8uk4Gh7D4SEwUQ3laJBAngu5AksFnDQAUf4YkZInlVdS7EJtAsi5MnTut0PW?=
 =?us-ascii?Q?ARO/Bq/jQAXrGd22oPEDH4c6uPfkCjCzwC/feGjaaJ8YirJ0ev7I/EghvbaF?=
 =?us-ascii?Q?I3fB1CfHywA8ASj+Pu/7XtIILdfudaaAYH9qux0nQWelU+RNSLHmy9vx0+Em?=
 =?us-ascii?Q?cpsuI8RLQZ/3O5sxAhUVxbnTiGQfWUKyyycqFbeUPCcRW3ZlFeZh4yq+I5/H?=
 =?us-ascii?Q?Rv8V+DD77eOmXiUbiGaENXvytmFaZhppaQ4RKQjGcXo09/8MZY1bud3n2yX4?=
 =?us-ascii?Q?/bPvwbi3UA1x1mck+lk7zeIp6/cKllBEboUjHaE3E7Jyx1GP44ePM6xHB6Ok?=
 =?us-ascii?Q?AeBLxQLTvOHB3XN8FiKKHc39FK9+kP5ej2ZBmEhBGsISFe4ooMVrEbYEUW9B?=
 =?us-ascii?Q?3aI4BmizfAVTpo2K5GY25kSzzKOkYmACoLRnFYXvV7foH5x1CWeseYS8vgvH?=
 =?us-ascii?Q?fbcKuSqhoWSK7nCq+n0tT48iiuz12WrUc6vC6kUatUpY0ewkRdiJvnVejFWk?=
 =?us-ascii?Q?c3v18dc6U7KashttxMSneSQ4Sk/tS6QblQARkEq+VvkSCa1MHgDf9du2M7+Q?=
 =?us-ascii?Q?Bi64fduPX3pwX7/1U0Iktu1Hdkm5G0nNyQqiTaPlZL4yv/oOHCEtrrRuTHQU?=
 =?us-ascii?Q?clGGFR7arDPtfGldhvceKrST07RdmCsRLuVOxNco+HXKGe2n5xNxYSc3KB5s?=
 =?us-ascii?Q?FfQN64UYJMxEZaROELBgqi9H5Z1iZ0Wt0YCvCwUpkoWZEkfo46OpoakXxbu8?=
 =?us-ascii?Q?Tq/a+Px05jvIclyv3LMx+dJptIl8pC7oH+BSR6mtYH781rZDEY9jE4RSlnnn?=
 =?us-ascii?Q?K5GSqrPriDI+t4UiXPH7wWlTiTmOfppzF0aP9Q4JojeXGgfWUBtCg9pPOHKM?=
 =?us-ascii?Q?BXuqO6IGwYAbhVw67PKafpzQghm9Ee5xxTrlkP4w0/FYEek7Gtcm/9o8K5s4?=
 =?us-ascii?Q?pKhxAniKV2+m1WyEK8RyMFIXn1JK68/1fgXy99o9NsOhVVKQDES1Bqs/WiAX?=
 =?us-ascii?Q?6ckIe9oYW7BG3l0NmT6w2OAx+6ojYzcBKRyfwD7ufnn/ArgWZWJJ/Sm7k4rU?=
 =?us-ascii?Q?QxqHJ7zGqtymJwsiLJD+JzVlaN6rFvYoI5L6IdTHG48?=
X-Microsoft-Antispam-Message-Info: T9+fgp1EqmnY0M4RsxqH1Ys7x8abCZnHMs+fERPtzfICAGjWDKVJ6nlM+xveG+lsxWOfAjveplD8Kpvj//ECfUW0psLEZj0au9PkouqsgnHbs411Mi+gNh9noTOqNtr40ITonGyukbLa/1QuXzf9KrfAlfYjQDmQHpds7Jbfoxdm5VNArDHgTjAAS+5KKXz1P43+2rJoIcTi8VaRulDBh1waUgY6hW06PBTglOcvmYR6xY7wpy7nOxA64BERvqhMklirRFbKxOpKwNrrcUOzAUY9r3mjvqlyb1Q4cQv2IbbkFxpMkfQz+55YpVJ5/iOBC1jopiFMWGW7l7A0ztTuT2hH2ZXZ8Rffs6yXbxD+cbY=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:4voRjlHOs75osL9uwur9kLmLtYjzVz+PUO5BZR5KSmv57JkVHhs8n2QyMXwqOikmoXZJ8jhHH3CIxNatgxsBfQbCCnpHymeaXbZIvZPeP1OA/rOdR66pwQwl1MxH/TNzZEWZ718k6F41kJfjKrZCexfSP//zoSOcd34D/4nsEcXTCZJru9fdkms+jttMK3djJ2ojFgDoWaeLRdxwenJGz6aRNjT40Ck14kAD62EMwHUsCVi3jEdk786m2oMdvd/t5ralvPEUDRpw2R2yTiRT3gMvvLin1jp5+riVtHFhfZX4Md46KS4A2Rj/YOCoqVGcZ+1KVDh6laRYSFjVn8ZIRxBdBbsS6KP1ZkbzmIY5WxRr5RIjhdnSDGrnE7iACOQ90RN27n4U+QTznN9sVyojtjt8l18nRm/Y50pZepR5MxQIs2g1q6Rd3bJprAjOqNmiNAy9RUdZnunjqu/fdKuAEw==;5:UliYCEpCwskzjCJtDNHyYlM7spzmFKL59/bXovkyIRznoyvurieh6jmdnDj/hLNQHGmtJL1AhaxrcTgMShn6f62FS3X6ns36InZlTTz2XlDtaKlAd4SxaD8m0huu8itLQeNcsAJjzIlxbGqw2Qyd1PtVSJbtwmrDa9efo6uJ038=;24:gB517grawj2f90jbTPqfNKsdyxr9PY9s/uMC5MrA5a8dHFellqoqtaCJ1+PxAXPvDCOAvN4r7M1XcSesrXEDTZn5zKrq6FCLGPpNuZpThYk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:fP0L8VyRSz0dT+IZwNfn+63DwBIBgDkMESgq5mk634EzxKVB3wgLqPJC6m7vofW7g+YcJRgzq3wrrfS7/mCbJdgWdw89gkpFs99B1TurzJtej1XOzYAzyYsk1UR2yI+PNQfj/CLzI1r0QIwBtf3y6RZPBlgiJJYTF/32R5tGrmTKkk+0OnBDFPpdMYp3pWLn4OzvJ63SqpZyVRLAgAvDRhGQrjvfYEjEk9x6zT24MTsxSUl5jZ23lCdSbzZxm84P;20:CYmGSt5B8RprCMUPX/hB/vaJZVfvExohroB8p8DQy7jNEcVHnV4dE0oNi7664jc9636za500SOc1LL7r/IlG06hMKJYuwhfH3M/Xi166wB93tzGpIQUoWyA8MQEkDDfPwvp+quwpsX6Y4sVfdCl0mcwJMzKPNQpt4ax1SkpZa38=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:47:59.0672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b80064-dd7c-477c-fb98-08d5dd16e838
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

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 128fb0e39b4d..25ba744d2364 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -41,6 +41,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index f7c00bd6f8e4..f0a809868f92 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -189,6 +191,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -211,6 +214,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
 		list_for_each_entry(pl, progs, node)
 			if (pl->prog == prog)
@@ -218,24 +225,33 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 				return -EINVAL;
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -258,10 +274,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -277,6 +296,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -357,6 +379,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

