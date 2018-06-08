Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fO0YBF6SGlsTcQAAmS7hNA
	; Fri, 08 Jun 2018 14:27:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E34C0607DC; Fri,  8 Jun 2018 14:27:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="elz/DDjs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C646960590;
	Fri,  8 Jun 2018 14:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C646960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeFHO1j (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:27:39 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:3680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751523AbeFHO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAxhcfLLAuazgFgMAfLU60k3X137EbfwoDG5GyIjf28=;
 b=elz/DDjs47PfY9rQtK1U5fdpRNYr/bhuDM9pzK576MuUv63Kb21GNrQyGqK4JjjlNSP9V9Wqf7Qo/J29ohz0pj666HfsL5nA80b7yrOnKwGeg6R3FpxklzZXo9f7BLQkzjTWZMOUpqaKfPkC5LSf4p3Yof90m6QvVcQPgmjWZLs=
Received: from finist_ce7.work (195.214.232.6) by
 VI1PR08MB3117.eurprd08.prod.outlook.com (2603:10a6:803:46::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 14:27:32 +0000
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fs/lock: show locks info owned by dead/invisible processes
Date: Fri,  8 Jun 2018 17:27:10 +0300
Message-Id: <20180608142712.32460-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3117;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;3:QRhfIlFHKFtG7kohhxbgmG+FnnnFomlAX2DFIn+fBOpKDVKyxNrhgIB1I6eUBakrgma4ksNi/BIyqTgq1A3a4IYV46rIoh1q1GmHE5/LfPApe0PUb7CtC1bUIEpcuVRfwBz8OgQpV5iBg2WAr6COZbshfC/NUdZpUi0+fyrwjwgH39FIuqtJV21xwM0Ocwf6xrt3U5zZAZ5TYTEmo+J+CdPNgIbN7JIlKY7/ylBd6kRHNStLu6PkgPup2qQSeq2L;25:QScWuQKJwj3m8iZQFuhWjiHdPC2eqx21gGfvI5TU7qYkgN+xgb6W1C/fSu/ZhrzMGpG3QBkK+v7MvOu7y2rWc2AAvDVQ9gCZRA9h+/VpvnGXS15mzGqDuqg9s6G9COEcro5VSgu7YX2eAy6/UR0suOne72Vvkf6fdMgP963XcmLbjM/J9mbswUXvdRnH59GsxBVzRgk0IWUu9WW9xW0qclE0fPqcLHMdI3CWUaF2iojmDYIUVAPnwi5A1Z4G8X+1d0KXU0EVj76lhuZtTF5nosro8HRpsdQyHsaQzep3KELSrN5OSoG0WvQcxs9VwQONLsHhyXv/ML36XfB4uX4T7A==;31:LP8LdxK6nlADQWkLWyWgVwmgV6nqI6wy8dOFiMDYmtbZ65iPAxwL995LjpT6XQLLybN98KFOyg9ri1i6rCsxdnHIR+yOBpB5CAz70HqBz/Ts5oNlwHDWIjjh5jkDAkoPYT+4ucIi422vYi1zrkccNBcrcas6hOOJPg2RvSVs5AjYWXQMVczv42fYxrz68jKDyCapcPjN94Qk6Q9EBzjvHt/smVCGCP0GkopZXZFo4/M=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3117:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;20:s1W9SaT4cW/aZIa4TWXxkjX8/70znj8/TTF4itJP/oSCnDYmPihIdQZLSnaYcJa1yecbBrvH+WjtDFzqhmQTefRqo2sx8FB96J9QK3naWGsI/tTexQwZAlh0MLpF5kAN+HMdBAsLLPBCCfepgPlT4vMysAmhwMwOdcGFIoFRxhsZlWMaTutcFrZFGd+FT9DiB77s4f0Iswvu/P3KVBi/Fz6OTWA93SN50f4cnIcb+aY2mxPMDdZV7/zRulalN/QiVF7WyIgdNTg2o37MoguJUm/qyd7XC2TeMFevFR5D4w7eqiV626bHQulqHANFGF36uGDO1SOygutyludCwwsONjbS6i4eNqrbb+VtZj7LdaKZCLrxf94NBK/EiYstFHXtTAFcnHA8OXH/GgpTc7AwBWYwCuPzf72J/EgohvIRbbGJ9dg0I0o9CHR+bcIR4q4wdT8tqpdexVscBp/O2hnDbvrccTnD50kVdesxmo+tphVtzgyiSjsthST6zSVNZUew;4:VeL6Szmx4PIivEuBk4BWaXCaaZa9OMQeC1Kc55j8Ik4NnNl/a7dbTzIuEG8+REBbOnpj4FvdszTlGBWjn0U43aE8dwZ6A+9N1qdOAwY553geO+SQC0V2tu8s8JuKKAl/7/Q6wNDrMdKIODFFeGHm5WS/gnP6db7FwvX/DM/DadTcPl4+9fSYasEYivzgtE0URE3dGhZNcGJ5OyPiKvtuLECCLF5qX86PBzgOst2j3AIbFRIAt3KBhQdjLZI5OLm4ZKARasva+IAo5aU9nZA5mQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB311729679F9204B5214195B9C87B0@VI1PR08MB3117.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3117;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3117;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39850400004)(346002)(376002)(199004)(189003)(16526019)(52116002)(51416003)(3846002)(478600001)(1076002)(6116002)(69596002)(386003)(6506007)(66066001)(5660300001)(6512007)(25786009)(47776003)(36756003)(305945005)(8936002)(50226002)(956004)(81156014)(8676002)(81166006)(59450400001)(476003)(48376002)(7736002)(2906002)(53936002)(2616005)(68736007)(486006)(106356001)(86362001)(21086003)(6486002)(105586002)(50466002)(316002)(16586007)(26005)(4326008)(110136005)(54906003)(97736004)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3117;H:finist_ce7.work;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3117;23:4x44ZdH+CpGHf6Xjsby695d3RbL6S+pvri1TzFnTw?=
 =?us-ascii?Q?d6Wvpqk7k0owRO85i9cqpM46nZ4zX60OPpR/c/+s8p8MX/jjTlvyhGekAj31?=
 =?us-ascii?Q?n4epHUTdbSMuqWozFLCIBG1NCC+SX9+RWx9j2pM6nDt94yA9zLuu+geboogi?=
 =?us-ascii?Q?TEHPxgwnoa07WIhU474P3f1/936eSm1j6ZQvXAINH51seUAH4OW6f1g318rD?=
 =?us-ascii?Q?K/V0LfAMeQFYiNoY9T0SZFQMIs/oT3KeQ3HlT3J5a2UoQ9gfuVNw8vXmFOxi?=
 =?us-ascii?Q?kGdhIqfeKo3z/8099p/Lehb9PagBJs8fjQNsLaOtqFI74zNSkko6GVaV/Azg?=
 =?us-ascii?Q?GxMh3H/aPCF7OfPp9pgEv8MHLQJ+ofhFI2KuwPE9nB8qEzrGuY7CBnQVfSdm?=
 =?us-ascii?Q?kuKEeVCCJ9G3x9Dy5U8umZqqwS4qr26wZXDT1OGGJjIL7EWNe3gFZzcM5UuX?=
 =?us-ascii?Q?KOEuVkZdFW6ZiR5E3nS7EGPp4EHJ9DTj5ExmSglzbYKnekeYj6LoaDBoNQFK?=
 =?us-ascii?Q?/+HfwSMq4hfOIe7emewTUXztCliEMT9lV+zsvK6D5QNAduPqaETCuMeSkXxq?=
 =?us-ascii?Q?ywc0SdHmYY24o97CIesVGP533t213rozOX2Wnp6292YswaAe3XlGHYYOKFkS?=
 =?us-ascii?Q?/ofFSeQg9ZxD8fiKDjF+IW+CxJipNfepHtQx+8aEMRlP956Y6jym5IL9hsre?=
 =?us-ascii?Q?bjUYRyCFavNVBmnD5seEI2lkzoiyLSafCka7ChWASIoo09yDTMNVnh5fNGKJ?=
 =?us-ascii?Q?c4rN8WLrTLQvR7E2gh7u1qpv5ySIJN4vOupvuDcfd14pyJbANvZ7mgHImTy/?=
 =?us-ascii?Q?r5KMWLlZyPbYRWqbJoXbMeiPztTq1uqz09eoGUgAWhl2lDLtHSDp15ScTs5O?=
 =?us-ascii?Q?UoT+WG+fS2tqcINl899Y4A2fle+k2QBCoRrSJyAC7o4s66omCFiLICbx+LBn?=
 =?us-ascii?Q?Vx8HQ0Brh2bP8rmqf8Ympbyn0PldojSuvqLZn8rDai9eaQfm9v+lrxkGISzT?=
 =?us-ascii?Q?P+2NuDzr4DMzs4Kak1EGmZCG8JasjeLnYuOcDg4rseZ5+WaDZz+rb3viVlB2?=
 =?us-ascii?Q?R159/XBiLCWLUypLKeAIprr2Ailufcfus0wPjA0tTXle7kCthaRQVfALPkcN?=
 =?us-ascii?Q?64PecRvc44Oma9wq9+OduWAIgzGTfAuJRkEO2Xh4iiTUJtf4GmPhVU2i+h3E?=
 =?us-ascii?Q?cUEqjCqyBbspX10PTR/O4gxZCMqTCXUKFfIoZVYEFcPHN9T6bVFcybajg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: uAPgUmUHenxlc9zJtw9mmkoneW9GOtgDUvtRLrJh4D0EGcYKuVxIYfvWIXp2Y5EvB+Lg1tUJWdCMseNoYo7N6z9tXFrvSwt7u8cHd6a1dwwhV6y5Nm7bNw2AFfdOPzQEdyGyNBnDtssvyiVscz4Ra47pLlcVPDxsw5cAY0oG7z2Ej0UgT9LmaJJL+LFH8M77
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;6:SP6OmR2YDEfLri3nyu/VSw/feQLHylzpDxEfYJlsFULlCfhCE4vnLkGt6vV2IsBzmZCU7A0lxvtruehDJvyxjDJmuZK0XYtR/O7+Rg1LA6Kl/9jyiHl2TrxaWRXctfWETjInv7X/WA5xrV/ELFYJNhyn7ipbjB8Hw7nei8is1Tk6S8vJx5sxvuWe7Psf1XWtVMLEqqhRIq+rH/t57hMK9t8611mwuhCzys6kZhG5171vdy7ck/S/nKTOGx07a4s+W58a8Y1yHehJkQNo3lT7e+1K6GHqg0IvrJyKE0/KFutbZdkDdHq45u9/LUeH0JdvQ4BPkm1XJyJbWE4IcnK5Cc3us0Ezb3ytI4SZ3UnrYQH2s1F6Ved1aQh27zeofpRMgJiKt3MB//rbgmJYYYC6bjp92pYprmtLxWMq7LtWDOBKGt/e6fxqwvIrnq9BLAmMHjJlvU9CRksJfmTj9dmyTA==;5:ZzS+ucSpS6SoB+XfoIitwfMcjIPnOFqYIc+n0uentR5T0BRvEdJe5GrL1KpeAPrtrNZY2sinMQGtW90ztKYnwAXLnksYUgV4JYgDuThg/EEbTVT4OR46fv1nCIgeIF2li+BlJDJ1EE5zX0E7IEPk8nGX6kQrlgoXpAiQmkQ3HJw=;24:wGsZuwV2jrk5FbkGvcIWJEMwFVEhhybMPuYZhqVW3RrSPiyQd+QYShbv4G4CfQwUocSLFMKL9iEWpkH1yOCXJ426gaiHtOXoLAAoPePbWP4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;7:ratfrvP15joArGnRkwT0c2mKnCIa3u6O62JHyPLl7IUXtGgIvhKsgb5XVJWyKAzkTlm2oPDqsica2V7ZGRYWh6Ed+IH/mzNXFuy3o0IPZw9quxXpsSlWefZpy4guuDkuPRe533zw0ghsaDqoLajmBhYL3VXkUW9SqGflWcADW+q/FyKXm3KI63iDcxh+uIfoS8VswPcN5Z7/Hg+461jzVt4HCd2cGpt51Qlla9uV/2bL2MQJLVh2xYBNd3qQSVim;20:jC/AqPE9RniWTYjYIq7KNBtml7imE3yH+CsDAolK1TaXR269KVHovb1OLEtEZmF5OCWbAmxvg8IWnXfjZ6gHqajLzC2f1XREUBgjxglBauQbDflNSwOsXJPtGBHYkkwenfqcpZZ5TqEfwFaXcXPWjPY2bvaMP10eLPs+48UGVNI=
X-MS-Office365-Filtering-Correlation-Id: 2b7e9a0f-42c1-4ec8-1149-08d5cd4bf956
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 14:27:32.3895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7e9a0f-42c1-4ec8-1149-08d5cd4bf956
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior has been changed after 9d5b86ac13c5 ("fs/locks: Remove fl_nspid
and use fs-specific l_pid for remote locks")
and now /proc/$PID/fdinfo/$FD does not show the info about the lock
* if the flock owner process is dead and its pid has been already freed
or
* if the lock owner is not visible in current pidns.

CRIU uses this interface to store locks info during dump and thus can break
on v4.13 and newer.

So let's show info about locks anyway in described cases (like it was before
9d5b86ac13c5), but show pid number saved in file_lock struct if we are in
init_pid_ns (patch 1) or just zero otherwise (patch 2) like we do with SID.

Reproducer:
process A       process A1      process A2
fork()--------->
exit()          open()
                flock()
                fork()--------->
                exit()          sleep()

Before the patch:
================
(root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 257
lock:   (root@vz7)/:

After the patch:
===============
(root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 295
lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF

===============
# cat flock1.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/file.h>
#include <fcntl.h>

int main(void)
{
        int fd;
        int err;
        pid_t child_pid;

        child_pid = fork();
        if (child_pid == -1)
                perror("fork failed");
        if (child_pid) {
                exit(0);
        }

        fd = open("/tmp/a", O_CREAT | O_RDWR);
        if (fd == -1)
                perror("Failed to open the file");

        err = flock(fd, LOCK_EX);
        if (err == -1)
                perror("flock failed");

        child_pid = fork();
        if (child_pid == -1)
                perror("fork failed");
        if (child_pid)
                exit(0);

        sleep(10000);

        return 0;
}

Konstantin Khorenko (2):
  fs/lock: skip lock owner pid translation in case we are in init_pid_ns
  fs/lock: show locks taken by processes from another pidns

 fs/locks.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.15.1
