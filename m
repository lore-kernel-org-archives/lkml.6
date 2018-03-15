Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932416AbeCOPBo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:01:44 -0400
Received: from mail-he1eur01on0120.outbound.protection.outlook.com ([104.47.0.120]:40024
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752757AbeCOPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:01:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH RFC] xfs,
 memcg: Call xfs_fs_nr_cached_objects() only in case of global
 reclaim
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date: Thu, 15 Mar 2018 18:01:34 +0300
Message-ID: <152112607662.7371.16175767692798928059.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::18) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7100ce62-b638-4ec3-772e-08d58a85a6f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:9nE7KJIkWECgRn+rBZ2h2nZ/3NChfhdpAouYOy+u8mYUx4pMbVIAszr57qYeWck/vK906l1RMeXRbFdeD/LMQrIWJkKGRYvzQsjEifLlrndqDABdVvosXRD2itivLYUuIHY04kfFc7lDK8YWq+Jg+/Jl+RtdvLggeaQwAn0cxkFEgvnQv2G09cIoDmQFmVE7UqxiklaS7CXvDBWcMpVmO0sn2TlJfj5rkk5j1BiX93Apz2l0AKHXPAQtU/ynHUtH;25:BhayKjdEyoKkOBjpoIK8mpp9fr7UsHyV2LnKfJ+BQ05LtkSJNAH2Ij0wKjHrvJdjU9qCF5mOFEO4oL28/Bmn1ShSQBSWqLI8f1UC7Yh/16ZAnSljWHqxQwNjLTwCPxtjKK1rpbvq/u0cEw7Y/P2AFBDouCWz5QwpnSjC3csPsvAgBdFxwNNsd38S3hLL8/itZPKQOFuyts2gukhPOGCf+usMjpOu3/rgyqd4QKr8vbLuCeGKzVMV5LXKeeJ0/TTOxzI/cTjVfNf94Yqt3vdeCjAA00r8fy6XNDTiSo3KAc6dV4ttFJjr8ovn+VP4UXX98+khf8IbaQ+LSUNrs7G7NQ==;31:a52L6O2p860H3g+2WVbVqHihz6GF+5kM3teJDzM8GQNe+WzvQV/BoQNpP4wgQBndsdYBcdxO4ITbWGAt0N2B+zuus1kRIFgG7Q0TKXG3BnrjPmIwJvMdFq6gV3jaGeaNySDKjlVBrMiuKoCGPcAyu+yh7qRIHQQr4lTDHC8GROt8L+AIY45LyPIuxaN6RCal6HlMTT1QEvwpwFD9iBq0IvwvCeZL/dhjVukkuoln8lk=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:Maar5zuTK704wIs/ghI6oqSanvTaCWD7oSxSd1BPz6J8a+MXdie3mpvyVwgtUI6FawoQ8oZei1ufcpIBPTC0QTl2oSEh/XJFWukIyTw597wQDNoFLHAE+QdVVodIZBWfTitIpRa5SQCbVjHGF5vBVqRRgXIszUk9OPlxtpQX6QjTbeW0pexClXYlX4TGF234WgYJWhtVRWdIgjbKr+okhoSVj/ytVkhFJ0ybxlfidZDdBUMWbFWAz5RCjJtI6J5ERacpBe7vFzB38Fbkzp+pH0FOWDYU9/YpKD0BYjm3iDFsRO9g9q3iPigcEP+9Ai3eU3ykyJP0OtTE0sDdrIuZ2MDqt87ErNUb2EZNlAxesiQVLj159flUPAk9Gmr8swExSBuO9DCogu/PsrLnuSrhYbNxu+NfSIk4lNqu3QsE9qUmrcSBFXXUM50sG+nLM3vU8c/hmUdV0c2H75gHT0OicWy4IwmfHqtwTAHsQptvFvfru412W1+DPs3OlGV+ixIq;4:KmaB2+HNUf1UJwPlapYiddLcpDyZiaQd2Vk2QmA+t6yqRoaqBktPcjVXC0Gzceham9bnbGAOUdoFpgYrxnGguHwGGA4pHn/hTkLprsYA79IOIaG7/NGajFNSuORSCK/echIMIOXSEBUz2yHrYWr8u+wPeOx3ReHKCPH8gecTodhP7cFyWUjzuRcqUGoa5QUYsgYuraGh0aH+DYVbdCF0w21iOO2VvGwpJD8/0qsqgx980RMlF5ddQpyUWQjDIGGg9cTlL9TSllbfdGVLdB8ETlYo6gTTGzmTV+FcMKGsVM2Fc7picCvlIV1RHmuCM8ls
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342752D0275CA53950FC781CDD00@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(39850400004)(346002)(39380400002)(366004)(199004)(189003)(52116002)(6666003)(9686003)(230700001)(58126008)(2486003)(5660300001)(23676004)(8936002)(106356001)(6116002)(33896004)(81166006)(7696005)(81156014)(53936002)(16526019)(305945005)(3846002)(478600001)(68736007)(8676002)(61506002)(55016002)(2906002)(7736002)(25786009)(105586002)(316002)(186003)(50466002)(55236004)(386003)(103116003)(6506007)(47776003)(66066001)(97736004)(26005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6bUJlZXdhdS84bC93dTJqd2ZOeW9PWStR?=
 =?utf-8?B?TG9xa2ZtWGVXdWVlQXp1R083Q01wT3VsQlIzdSt5MDBvS0pjcGdkVmw4bVFG?=
 =?utf-8?B?T2RsZlVram1ldEZTd2N2MVljaGhCaGMvNDNRdDFJUlhlNllJOTFYenJ1SmJn?=
 =?utf-8?B?Mkl0c0dlSkthM2t1cm1yaEtNcE9yNUpobUUyNFlXQUVsbFlySkx5L1cyVXF5?=
 =?utf-8?B?ZDYwUE1TelZUVStyZ21lcEUvZmttR0NaYk5zc2EyVUplTHJKWHhPZ1R0Umt2?=
 =?utf-8?B?Z1YvM1cxUlFKUXRFaUtYbkd3UCtZWENvV3N0Y1NtQXhoVHlsL2ZzRFozNVZQ?=
 =?utf-8?B?S2xpVktmVFVSbHZTOGU4YnljZHJXdW1rZHF2b0NxQ1lmS2NYWTNVQWV0Y2w1?=
 =?utf-8?B?Y0pEV1hjNEZoS3hLdE9QUEs5QzhFVHkyK0NmbkdPZmwvRnB4NXlRczlVbDBM?=
 =?utf-8?B?WWx3dHl6ZlJxNFFFaE84MlpIZE9LWlR4NkhsVkRJVUZaNkYxZUdLQVVEVlRF?=
 =?utf-8?B?THNlUVU1NXJreW93RWJjWVFjTWdPRkk0NU9LWFh2cUwzT0dWeFRoUW1xZGpM?=
 =?utf-8?B?VEMwbGN1TzNYWTJvUXdacUVXMHNrbm85ZjNlT1JOK3RMWDBBZlpMc0pHN0FB?=
 =?utf-8?B?NHo2Y1pWVXQ3Slk1ZGo1alU1MmZaVFBOTGwwVGpHU09wZ1JEOG43NURqaWFr?=
 =?utf-8?B?Q1JQZ2xuM1VIQkRyU2l6cEE2M0FESlBHNU4vUTRkNEJvcXN6alhrOGw3ZlJD?=
 =?utf-8?B?Zmxldy9qMEQxVWg1aUw3NzJNaVRpVXVKcWlJYVJQK0xnL2IrZko5WFp4aGd0?=
 =?utf-8?B?ZmN1SFdVTmw4TGxKOGZHWFlURG9qTEdNajNrdmprdlYwc1htb2ZvUFZwajZo?=
 =?utf-8?B?eU13Q21UZ0prZmg0OUhWeXZOVkVmV0h5LzN3NThKaWZPdnhtajNjd1VEVTli?=
 =?utf-8?B?NEpjQlJZTVRReFluclFvVzd1Qml1RGF3d29iaGVxMnpBSVVWWi9BM0ovZjZx?=
 =?utf-8?B?NHBaK0VKVEh4dzhkemY0anQrYlJCb3Axc0lSek9nUjI2MkY5UEEyL2hlRzVZ?=
 =?utf-8?B?bW0wSW4yY3JDWnlSRHQ2QWFBcFM2ZElrNTdWblk3Y1VPdFNXZURwejBNaEV5?=
 =?utf-8?B?d0tKS29SQU13WlBNeDZsTXp0alc3VzVTZklkQ0VJZjlMOW5BNFNzUXgvVDU1?=
 =?utf-8?B?a1JGd0FqLzZwMHQ3OG9za2cxVU45V3ZVU3pPOXI2SHFORnJydHhlcjdwRXRU?=
 =?utf-8?B?dTFlc2lRYU4zN1VvcmU1Zjd1Q3dMdlp0bVQwUjUrQzRueFBmcjN3MWpKWFpa?=
 =?utf-8?B?ZjJyUlNkUE5sSmpmT0ladG9kVk41L3VGcFFwSlV3a0gwQ09PYThablU2R3Nj?=
 =?utf-8?B?VEN6S3NadWRzQzEyY3hGaXV4Tk4wcGhXYjRHckZOdEdBUzJ6Vjh0eGRrQmh0?=
 =?utf-8?B?eUhRVXFDOVpXai9FL1pIaWtGMFF3L1JTNlUveW50MTVTRURtcGVtSGUxV2FI?=
 =?utf-8?Q?S8zYkkp6LZcrUwKDml72Sh6FVrE=3D?=
X-Microsoft-Antispam-Message-Info: S3sargYL5TnGmlvCM0Fxt4oi1Wa9xzw+SmMJz1S+M2qLmPGgVNJqzh/lnz6K9pr3e+9R0JEaM2alPrb4ePfoo0F9G5UuAm62raSixOeQ98DrRPhJNcISgEYW98KxRgv2LergDSnPBwXzMeJRyxMbpLGqJLWrXbsgQmQn7RIs6k1ei56CsgBScegP4Us1RkHj
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:BeAlqsBpldsbd30XZWlbT+T7BBOY2mWZ6RTrPVkd7rQ7k3bqXwg3Qyehe25pM5lxAhhWmlC9O1Nc7wb1kMEjKIoGWt0Of2Qs65bLM0ytqJHIIOsWfw8DYL35UKqoxnpzAsdKAwDA7KZVL6JheJO4n2PrpHR9GbuZZz/EZlnD92c0IUKCx1OwkVYKnWPdwkmn2yZHz4z+OuMqxRTL7nwj0ILCDhPczAcVjqDZcK6mVRvbmhlEiHu3F3cuReQt6+Yr0TeVd/6SJLRkFEmcxTyz4AifVs1CRc2N8V4jlh2tFFv6JBqWDlVGbY47O+9v8BMSRnxzPPDD3Fl3XQp34rvZEeZnE08O+e1Ioor1j5omF4s=;5:7fH2iJhsTgVYZYniLU1Ee36AdUAi86wi/CEhmxyxpAt/+AD8HfwgAnJ8WwPlpzzMmHM1COwlp5LkR42fsBXJibgTnyqk9jALsar3znHOYXF+ry+mDtO0/Ajyj2r8222ngiEcDXv5RvBJXIFVw8QZDznM4VJatcj/cocHGR6w/Jc=;24:Oj31WsH1AjVtNQ1A0Ya6NLMh/JRX42AJOuTfhjvjZax6odrh32qVjCOKmdAszTaRgOpSBUadcZnMwUi5PTEIfGkbMenmUl4vF+Ta3a9PzDY=;7:+ISTyOuSYF5+/QedD73OmNLPEb3k/0Nmda0fbhoAhC/erV//GYLkZPCN46MK6Yh14NmZTHAw5HLDzrrfIvUK+Uo3lw+6eTERgiiJHGh9euEMmIc3IODtHetzGXCmuWTJrHi2pIZxAuZkSYIbnjkWlwXpQ8NyijVx75LGP3U4s3H0xSS3JddYsFegrsxPLxRalA1l+SjVx69tx+AInANPwFmG1SzguYfrCzA7FDt4XcK6zzk6IiJpmg1p9DwXiFZC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:trZ7J7DHf495HPNpyu18eLhgUA90dLP4mJG6fF6sbKkepnHl5Rj3HehRuphhlg/tEBHD21irjb8tL7VM6vP73MuB/eVyLZDjrsk7iHcYHt3il8TybbXkpzV/vYjGii4vLL8A00LKiPXNfaUwshSJGOooqyPv1HOcko4yttNBEsY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 15:01:37.4755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7100ce62-b638-4ec3-772e-08d58a85a6f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_reclaim_inodes_count(XFS_M(sb)) does not care about memcg.
So, it's called for memcg reclaim too, e.g. this list is shrinked
disproportionality to another lists.

This looks confusing, so I'm reporting about this.
Consider this patch as RFC.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/xfs/xfs_super.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 951271f57d00..124568aefa94 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1788,6 +1788,8 @@ xfs_fs_nr_cached_objects(
 	struct super_block	*sb,
 	struct shrink_control	*sc)
 {
+	if (sc->memcg)
+		return 0;
 	return xfs_reclaim_inodes_count(XFS_M(sb));
 }
 
