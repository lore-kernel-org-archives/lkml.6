Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6B23FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T15QNS8X";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gb4OvUFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C6B23FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeGEUwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:52:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754058AbeGEUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:36 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmMvP015385;
        Thu, 5 Jul 2018 13:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Am+x/2/zeSaGaS2nqy6LREwYTuc1gH8bzaWZaL7hX7I=;
 b=T15QNS8Xq+2dDnitCD4w/gJQYFzk0oJjvZ5o5tn5vcp/WmeCwjv0qOZFkbBQbXR6Qicq
 A6sTZ6Gksvt4prUiHNVptjr5TiPHBZzXlCKz1vsG6nzmJt+kqkerR5OYzDJNzAwheHmc
 xWFCeCHSt5JleDH5kI2LyJgCt6vksGmOEQU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0eue-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am+x/2/zeSaGaS2nqy6LREwYTuc1gH8bzaWZaL7hX7I=;
 b=Gb4OvUFCBBTI2/ETCcSrCSBQZ/Eln1zE3wv+BnCbF69M7vSlwZfFuWjRiQ/H6DohglkQtIllFcmYQ8QyzuK+UOYJ5cSkwJaBdzQxyEosm1aIQN5I2j/Pv2936LuwP32wqunDEDMBqL+a0HWwNLb8Z5T7buUvJ90JOCEc/BjG7Ms=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 bpf-next 00/14] bpf: cgroup local storage
Date:   Thu, 5 Jul 2018 13:51:25 -0700
Message-ID: <20180705205139.3462-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6d4cac-8782-424a-39d7-08d5e2b92be7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:vaX8XFfmuhXDnbrneKeOPhLSVt53Fn2s5BWg10tw2BTlo1eFcyDRXwhgbzH2SFCRLMtiO8EmafLBqZ+lh5ZizVaCYkaT3+Yw97UYSoZuz1lEDFprvSKchmRgDUDGJ3QMx27fyo5ebsX507qClk1WVhmFZ7apoNV+kcRIEGdwPz7sZnFgj5BRgmgs2u7iY20yu1XPbRIWXIdahe9yTbpeCfRyb/duNad7BHufu/en7R/bE8FQa4GZA2+j6DeOm7jc;25:BTWM7JcO11xLBN7NCRAphcNTOTT4Pz8QlsLT8l5tu910ZFqAqs+CHGvGjlXGUkpIczrB9VdA2DCyZZjIX6ZueKkkZDr1AuivmXGh6MVIH/cx2ifJmm5OBIqdR4T0aAlDrnto6VsX4muX3dpTkbKWWcpu9pburLyRDazlXLKlCUpaZGk55os140h4OSZZ3PMLCtR7naWB0FVS+UzU8vb0maZNwXv1fFYPAixEcI4gtizsmiOaUmA0orL9zGN4kK+FnqHDwY4XiBLuxhXfuajkst1AE+/bRp8nMYCyTA4uuqpF+4XTAsryAQnE1w/kTnlK+0PGTVzLUX+1JhV42D15Ww==;31:WMve+9viBo3hJqZJAaHXQxudWu8ZyJrqzrw4gwNGt17GPsXHSOn6OHeYSFKN6EX8DdbEvcfqGxTvBF8FHmrv5T0wpYS2xqq8Aov5KCxEqlYUWNLo5LTzU/BAHXUTkLdRtjEUXgXEhjcxjxi/ac8v78Xe7DWbDI0k7nSKDUUW1Hr0nNF0lbXrKBrhsMTeIoap0ubvp6xcvfJ1W+46ze6zHdULTKu9OBdd6MzHX0gdYpU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:Z/roS/CPd3w01uBdtnTLJK++nnRIn7CErT6yMKTF5oputxFVVvQTUnf3AmqtUZomdVIpzgX46wbh3KCGjmzw6zPBsCvwMLR0glNjAZi9l4DyPNYNIX5rTzY6Qk6ddfGLEFju0cbMjGzzCBdUPhV6wToS+GspvBkAbM2AAFtsFqrrUWzoKQAaQyohEn0xFdwvBCEg0U4ECVS0h1kP6Za3wtCeL+ADG9g+I057MrBTp+E7IyEgok0bO1RIA2HBSMyxZ99MJFiJzxp2gbfzhZqPJxnc1RiJoMe9otjVrjA7+QkJ/ef9IXGr0cZi8rVNExOVg2tl6vDvIxhUeq/x7HxLLw/wFOzqNrWUmYtE0/eFWizws/IGAFYFecAw+kQIOPT8rN7OUDe/Y64md+sUsK5jN3ZgWZnm0NxAjw3gzKxkGtgJPa7ZNk7OK12+K5L1OSfWFoNlNPWAd65Pnu2LUClpqTfWVIToBTLWjfqXiPpTWWRUnt5BnpOquVdIuHeWhWT9;4:9O6flHQ6RR2FGLtol0Q/7BfrKnG0acVO0RTxKmSvYx1nN1LBVIln9DVODJgABLdzMj8wt5hCs7LKxZeK/GJ+oCOHG1OnWQzN3igeM/rjwNgXB+AxOUH+EiUB6Dt4HOx2DiR0prLVUV6wrA3s9YifyBgLO5Q9h8HeXPenWCuosGSC07ceIZ1wOmAbknPcfHTSklL5/lSOlQonE1m79sjdV1A16zeYVw4GDbO6xvr85l9yQGIdHxnMo0HQtRCq2oFqES7ruQijK+DmDq4wSD9r4q9/+Qwm3VciBljX7DmrfCf4p4d0TKFrp7+JvMOmM2uf
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166B685547E72DF6FC9C570BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:MNV+ZpF5vHvG/fFd2kRoXJDtDCgj1+Uj5keNmvcXp?=
 =?us-ascii?Q?JJKYOwdY3I2ZM5MhGeiZFIdKDfenQ5mWIglrdaMXWMNHQHgtAiA2FZ+L8ZT/?=
 =?us-ascii?Q?hCFK7WV+aJnkDFNChsxOWE/P1Jxsj3Njwv0k6eWKLwsEQi8O5cSPWWYgFNME?=
 =?us-ascii?Q?67sKBbn5ajcWfZeYmt61T37eGLSUQzs+Ykxuzh47+/2QcCd5alnTTwqPEKU5?=
 =?us-ascii?Q?ttr2WbvyJHIlSwctOkJtFVjnL/ezlci7DPLcmIapPowFohnUDc/4SneapRVF?=
 =?us-ascii?Q?lGowTsRz/e/BBWG7pu0maC701YIttqnjBdXKXVVxWjrV7lT5PjfD9/Hx0e1o?=
 =?us-ascii?Q?ji37KYmGP/Ykgl26MZkR8LfrYr3aCBwEdPfIeodQ4tb5s/6GRLVPqyTF+D5y?=
 =?us-ascii?Q?M4P8A0cYiyxtwuziF0VBFqOeeJzd12Oz+PssakcOhvUGpCpTC8fG869WrGYk?=
 =?us-ascii?Q?W5CRuAwbSG1i/XL+RoEXVj4xpi6OjWe4xOlkyrhPL+8CJLCJYRCBe88novw9?=
 =?us-ascii?Q?2zuDaNn/AulXO7LGubX4BH+L9lC7SGo6vDC8H6/hnQRw8SVJDQVp3jz2bvXX?=
 =?us-ascii?Q?R8ShtpYx0hynMoAcik61TSeZ6//2NpZcvbJ08IfUBrzEUPLn41UXTl82y/Tw?=
 =?us-ascii?Q?YLa7JHLd+3Oz5q4jm9wuOoYnsUJ2ZUBvMj3Pb1Po6iedda47SD5KIJ3eC70u?=
 =?us-ascii?Q?tqXCv0oqvB2cGsU+yvxcjuNvaQHZ1A5yyWpmVX/OaFGiPxNEoHvwCqdxDQUh?=
 =?us-ascii?Q?nxWAm405VJJ7DqPKXIxDY/0SyW7jq3cvi1WJytP1rGs82eb8BTKv/6ehOO7J?=
 =?us-ascii?Q?fPUFjtWDrX1xVFj2fnSoZApGzbXGdy0DB9b8pDpkcpCBPMZujm3C5E38wdGk?=
 =?us-ascii?Q?MbvbS6fxvgJkUog+27iwkTcAfSE4YSKuEMrTCjnqQS0WkS0EsTveJDx3JIg7?=
 =?us-ascii?Q?aBnBrArqnBTNAxmynkrzZhoxSJSKAdBpvbTOwUqfZVgGjgwrY8Ad5q3KOG0A?=
 =?us-ascii?Q?I3FOMHE2XdT0vfPW21KiJu/YpjPUWmiJYG2sHtpO+uHYf7UgxMfAes+1nX7O?=
 =?us-ascii?Q?cvWvgoLWB4iWgqbT27VVvFWrjywO7vQZ0bVJemQv0sNvE0X2XdNERqaBFWWk?=
 =?us-ascii?Q?m+PXCPW87kw7d6afFjUcYfC0yoc7ma6eXqX3sO722nTW8JvlKYnx7Va8fIC2?=
 =?us-ascii?Q?dHJqcul6VslQoUGCuiP/C+isUNWvM8/90KDvpYHoAWJrI9Y1bMdex/EbQP7+?=
 =?us-ascii?Q?EIm4hGY801GJNesu30=3D?=
X-Microsoft-Antispam-Message-Info: XWM773glay6SbER/ehsXNyrfZP48SuvCZoeJ9jgKXZbX4obxqp1jawUA/9azfrMDxT+LDyen767HG9gcU909cCWT2bHUjPE2Y24TvPzH/QhJOvx/YnygKEUwklu7xTmzeUMAlOGl0/GSByNAIIdXZHW1DSi0PKRPgNW1fUJn5d43j8j+9BoqbPJmxKrnoh+3SdbY/EaWY8sVdlboxprp+o8cyKQ6sodmlE9v2nD7sX97LJ8Ud1VnfJ3x8ZNvEJpcLEGKos1dZVMbSUa8ADPOUpUNpSoYQjO7RI7Recp2r/3bmx1PhhepyiYsC9JKTVLnVfK0W2k9Vi7OnR9lsip9Qq15eyPyv7M1MyW0l0kGHvE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:j5gUqeI3nImbf6JMma/6qZDu6cW5Cym7swj8IkmLSNCT88yY+eczmWGNGu16frbhbA6ohnTdxhBTgieanjdsi3cP5oyFF1NU5Juvgv1OBnAaKdOeM0JLZlV2iaKsY1D4o/pDwl4+w0CMjNANbF4+pj3TOaAUgkcMA/X0iAuIvBHQXYVaL/hHmCWcEllqpjMomz+Fc7CQXGvaEV71ooyd61nwymWeMKtjXVNA8JmWe9HhJ2v22KNIsB0BHo5g+vm+1EU444msDRylNSBMlq3g3Uo34OPxydpAOqE+lJuEHWzjdCguC46AytGtEc5Gic09IFEoGD1fAxYtx7X//itj9DrLrboNG4rQJyZWQ3EcEIkhBmuHspBVRzyNnjPyXX7KArU9nsTll2sW/wnsEsxDf5yhgS5wt91x559I2lBoqGWkeE1GHYR75AEPe+/u5SJdFrsGB4/jDxOaKazQ6gKe1A==;5:G9xDdVilnqpTR8atoLQs25LsAJhwN9eSz48vRnmhoqVT7Vtq5w2924s+YRU6luY3ArTlMcAXqULb+HpQRicVB0IzRZtq5n57Jk8sQmV4yI9An1nBykMAwsctcFkgOsYzp4Q6pfMrqDeUIQJtupXzmQYBJiIMkjdaANbgBQimZDw=;24:QjXivkrMMLIoGE51Xiap9Zpo2CjLJnuC1fH84qezym5XWYw94Fp5Gt4VAZ1qP5QN3d0KZ0YAuyCfDbryyW6IUFog636+XlyTlfvnDBX7f9I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:oycAOCqSbNre1bU28RG25g+yymip86+lAjNrh88doPVzCIVdJzAZPKlHtsw/3dH7Z1rH21szco5h13aWr1iRP8bng90XCN74gS85MIzgt2Zzet5W2hFc2dT+ar9ZtfF4cRRZ7/CMpSuT+yM1RXfNoJroIfdAMcs7ENYo9GBg0c8IDFSJGt6KMt+PG8+BqRDvzqmWLrKHm2RFPcgiq9gH+K8s+aJBE9v4y69dcA1ET8RfHOMfZgdADRDE8z9Bg5z1;20:7i1TegQdR/WUCtI1avYyGrYzQUuKNvRwx/+u4QIdMUPbZACgDKAg7ZGDWXzKi2slzBzVqx+WWTkRpreEMt6abXirMVbVaJ+yKhKNP3z/DyvJj5PiZHO0Bgs7CPdBt8Jvl2Nd37jkpcGA3TcEnFi1ydyT7xcwx/4ho97oVJNIOYs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:06.8837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6d4cac-8782-424a-39d7-08d5e2b92be7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements cgroup local storage for bpf programs.
The main idea is to provide a fast accessible memory for storing
various per-cgroup data, e.g. number of transmitted packets.

Cgroup local storage looks as a special type of map for userspace,
and is accessible using generic bpf maps API for reading and
updating of the data. The (cgroup inode id, attachment type) pair
is used as a map key.

A user can't create new entries or destroy existing entries;
it happens automatically when a user attaches/detaches a bpf program
to a cgroup.

From a bpf program's point of view, cgroup storage is accessible
without lookup using the special get_local_storage() helper function.
It takes a map fd as an argument. It always returns a valid pointer
to the corresponding memory area.
To implement such a lookup-free access a pointer to the cgroup
storage is saved for an attachment of a bpf program to a cgroup,
if required by the program. Before running the program, it's saved
in a special global per-cpu variable, which is accessible from the
get_local_storage() helper.

This patchset implement only cgroup local storage, however the API
is intentionally made extensible to support other local storage types
further: e.g. thread local storage, socket local storage, etc.

Patch (1) adds an ability to charge bpf maps for consuming memory
dynamically.
Patch (2) introduces cgroup storage maps.
Patch (3) implements a mechanism to pass cgroup storage pointer
to a bpf program.
Patch (4) implements allocation/releasing of cgroup local storage
on attaching/detaching of a bpf program to/from a cgroup.
Patch (5) extends bpf_prog_array to store cgroup storage pointers.
Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
non-necessary NULL-check in bpf programs.
Patch (7) disables creation of maps of cgroup storage maps.
Patch (8) introduces the get_local_storage() helper.
Patch (9) syncs bpf.h to tools/.
Patch (10) adds cgroup storage maps support to bpftool.
Patch (11) adds support for testing programs which are using
cgroup storage without actually attaching them to cgroups.
Patches (12), (13) and (14) are adding necessary tests.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>

v2->v1:
  - fixed build issues
  - removed explicit rlimit calls in patch 14
  - rebased to bpf-next

Roman Gushchin (14):
  bpf: add ability to charge bpf maps memory dynamically
  bpf: introduce cgroup storage maps
  bpf: pass a pointer to a cgroup storage using pcpu variable
  bpf: allocate cgroup storage entries on attaching bpf programs
  bpf: extend bpf_prog_array to store pointers to the cgroup storage
  bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
  bpf: don't allow create maps of cgroup local storages
  bpf: introduce the bpf_get_local_storage() helper function
  bpf: sync bpf.h to tools/
  bpftool: add support for CGROUP_STORAGE maps
  bpf/test_run: support cgroup local storage
  selftests/bpf: add verifier cgroup storage tests
  selftests/bpf: add a cgroup storage test
  samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

 include/linux/bpf-cgroup.h                        |  54 ++++
 include/linux/bpf.h                               |  25 +-
 include/linux/bpf_types.h                         |   3 +
 include/uapi/linux/bpf.h                          |  19 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  54 +++-
 kernel/bpf/core.c                                 |  77 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 369 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  53 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  21 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |   9 +-
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 123 +++++++-
 21 files changed, 961 insertions(+), 81 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

