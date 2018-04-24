Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeDXPcO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:32:14 -0400
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:48821
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeDXPcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:32:10 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
Date: Tue, 24 Apr 2018 11:30:35 -0400
Message-ID: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(39380400002)(2980300002)(428003)(199004)(189003)(110136005)(126002)(53416004)(104016004)(305945005)(50226002)(4326008)(6666003)(86362001)(8936002)(44832011)(50466002)(8676002)(47776003)(478600001)(81166006)(72206003)(5660300001)(2906002)(356003)(81156014)(36756003)(316002)(53936002)(54906003)(16586007)(59450400001)(97736004)(446003)(68736007)(26005)(76176011)(2616005)(48376002)(486006)(51416003)(7696005)(11346002)(106466001)(476003)(426003)(105586002)(77096007)(186003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0753;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT036;1:2pcY6MRsrLHLuS/8MuwNobGSOpwIjQLUJJ0w2gTSn66wePSK4T68+tTqytIDG3drbyD+5MQdINh3CaGGV+tvAaxV64pmK1XFUurXMlPA8/C0A3eleE5V4LZXvvrCQRk9
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0753;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0753;3:XkXuU1OUjpWqIUUfHy5qKmpp1hbYIqkja9xQD7oY22BiunXmPTTWooAoB2vkT5dNoIryoelCQQrXRRjCpCcOH5xsp0i5qEwfzTJi6jD8MW1bE+lxj6s8WvNzmEhpsZEf6jOUNzaABWkpALQqB/AY2R25XSx4XCioFk3l0osvJmmWZ9NexSChHyPMJtnXRcTIwMn3+bafGgF08+HgXFCIRaYKLsfEwK3Gmlte++tSY729kjbELNgpSZIzkthwWd9ejmiyAoat5wB6isirTTe4VSvCjCB74AGUWuhV/muagr4XqWyJZPQAdekP8umoAcbsVnIY0/4TGthjidiXdXX6VbgAI8G4SLZpe8nc5hZUSBU=;25:9tLimFqHWhEHxdZQ4zC7RQDn31un3YZpSyrRnAPYoR1bgO5y39yFLB4umTPO0STBxUEVYeATWWKpPqmekLyJSYiDvyvnIdA/9tlGJ/bqlXUrdV2FCMPTZ9oLv4qcXtqghhqkTRnHeI2uI8pi82FEKZZRGxgPSoPc+cBsSzO8qDJOkDq/YdnHr6jZeE//NgnXsPj4cGmYYbnd45t1S4UfQIWX/5c/rfy1e6bdnuZzwyJuCuhzbG6LM0rU3Nk9U1HSicT85u6gQdXnR2d5k25/Vn2veig8Q/oBCn8WpPAJHlooUvs9vV63vZV7UNwt7UOM6OLAotNLpKsD7u251G/rew==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0753:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0753;31:rX3gwD+SNDHoV8Q6KwtKaMQyDnlkigZv2RzppbitpgTLUu35aSA33fNquhqYDCe9bz4YqyoO5j4KDHiMcM4zUWZR8SJ1niKilrjgAVgdl92lHwKAisiAjYZP6ot9cD1uEvhoPihNwerjk+/7zMGl6mDigR4YVP1RghXluOVxznS/+3mN7hlZ9GjprCeeZEROoveQ/T+aGJH6EC3lrBQLM0KfA3pevPe3Kuk+rchy0rc=;20:v69hcJ8vuOjLOQLvPK35Pf2ryy+8Xgmr/rvvYdQSeUJN+He5nUrOy+778m9kB39nk7FZH1n//9BJ1DbkNEuVq2wDOTWLlpiMF1KtkymMznoLEcYbzsA+tBk2g4apC55ogN5fn4qb/qKSpamxtiREU2awxmGWCCVXvAn5ADJ71ZjfV/U2/cUXqCDGiKbeCsy2m+vRfknvU5HOuZF1dSRJ9q28xms04yISpMbhE7BODXD3oZTOqbLTJ8g4Td3NlCsgBD1eq03WeBqiA65nczYxCuweZexmQ0HvTpsNCupj2A3j6Rrh4pKzy2kx3Ke3VK4qkvy/bzZLPNmA6VwCCNQGeJuZbHxNKeAQINbyTVUu/ZGWO3nKMBo3j4+Uq/w/j0gKTiW5rhb1F+F1IobSN7QQuN/yiR4y5H0aOKJDIy9j+jEkPJBlxq1Oz3wR/eczsBiPFL3GkAamReO+kITj1f6cFUf3x1hfxPlLQE+oOMqGiYZPpID7ge7nrrKcdfpops9Z
X-Microsoft-Antispam-PRVS: <BN4PR12MB075383273C38A32A8D9EDD86EA880@BN4PR12MB0753.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN4PR12MB0753;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0753;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0753;4:XfokH5pl7/CKvmTIFLJP9hIXq8I9fLlZoJIosucyYITDTvXAwHj6WhEdHO4f2y7YB4Q6O9KJTsmWOV5u3vTpE4mkqXyARwLDOlC/LoKOY6BcblPmnphYP+7I7xxIZOE6jeFBpbujUCTVOQ4TYkJMKsduKhSsW38UNjXZHkfXoJpfGrVLALM/wuRnF7v1E8HXMafgYXsVJdN1gvwRqASMB7qrmV9WvkEFMZBpW+JBynVdutdX2E/1t1QLCiu/N0x3PXZH9pPN6RlDKbwlkYjZ3Wm9vSSXcucGqwA3b2CzXRIyhskyNR0xTwlKIKPvprAT
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0753;23:ZLoZqDWQ89LuJ14CpqJCR7rHd68G2/RIWyyzqSMDB?=
 =?us-ascii?Q?VcTdh1JnHF9SOTjMNYgoIJp1qkcdRWKj9HfhDqZLjzK71GZ2DoUkz90s3oNS?=
 =?us-ascii?Q?2Q3+HQdU70F0wgTC2Tb9jkYmfBMgkygrG919a4+y8yXNS9JTXMCdQQtPbHXk?=
 =?us-ascii?Q?cXy510eZ3cjH6h7VUy1OluBimGss+KtZk+5Z9+7ZHQKci8+5wnQ2C+4oO3Xd?=
 =?us-ascii?Q?zr9LeGH46JKBgnBXDlHL/sso0RMjyXvL78N5jCFelH+ubzycOamDRpP6Wm9L?=
 =?us-ascii?Q?ryVOWs/Pp0ou+EJD4sSxB06VfAsIEV3NX2CrQWiFsMEUKy6ipE+PHqkQfO5r?=
 =?us-ascii?Q?GrRxsR5m61D82heXXXadBXhkd5cOUW6umSN3YpmJ6RPxPfYl7B+faaS7k7Yo?=
 =?us-ascii?Q?2VVXJUgV71QcKOtn7o6c7X0Du7IwAlU3EnoPtT+maJFnkJg3f/Wtlkxhm0pG?=
 =?us-ascii?Q?Dm0IMS7gLYFsim82r2KdBWlrWoIYxmLL/tFygPU2RF70ntbiTaGpbgh4G8qw?=
 =?us-ascii?Q?5cblZ/DSSA+feGCTL5z/Ih0ns4/SttChSLQXNqkbzb7r105fLGTcp2bx4iFq?=
 =?us-ascii?Q?Kdp468L63GTu67XvU1f6LSGacejvO/VvM833RkKZp6IrrsrnAqJWSGS22Pi3?=
 =?us-ascii?Q?A+yF8NIZEmHSkl1uCRK8h7p9avMb7yA/aXcLf1yD4nbl8V+UW+KiCRTduGY1?=
 =?us-ascii?Q?oH88h4cKibM4gKRuRJLdrofTTartiGQhJ0ecdQW7swD11wFGDP3XPKJGoavY?=
 =?us-ascii?Q?+4ZRkputmyFpf7ePILcbLauSQCyEC0fwex6OTTi9HTW1DdJS5KCG5G5ddo7x?=
 =?us-ascii?Q?SExKzrYDww/DKBV2PYxdK/Bk1qhYJ/DdeOjZ4Ru69GauitUO04UxVoW+C/qU?=
 =?us-ascii?Q?Ha6xs0neEzFg8fb0fEiSR0t5vhRuI3l9w5cBP7bBk6dWb6Gszckb8NVthtUw?=
 =?us-ascii?Q?GNe7uHj+XZ2ujXXTjKjSDyQW9w4ywyiOHLUC/JH5BCVoN2yZkKtFk59Bh2/A?=
 =?us-ascii?Q?JI83oy/p6dhIVniaJKlLQwWrJC/cumBmQlU7FROnqQ2J0T2GlsFldfeUwYDZ?=
 =?us-ascii?Q?GkYinD7Wzm8qLwBASckQPik8/D98d4D7Ym8STTJAH8avdmaAjH48KqSf2/EM?=
 =?us-ascii?Q?3P4jeSXaZoywi/RMZ6hqyfCDryixULWDiJPcyzmLgjL3fDIAl1/8ThuD6qxp?=
 =?us-ascii?Q?xUzGnTNa4HhmJjEDcv4Oq4KBAjcz7IHOhtx?=
X-Microsoft-Antispam-Message-Info: Y5OYFYIG6TWqXPonE+25W2Pj1I0pF4VWbaecL+UDaK6J6Wx0H6ZOiZKzKFolBtbw1isU1AS6HEUFI1zhRYK8RTZwLPF15QU6Zr7uEH5arTk82Uawrg16PJ4YnFWshOVTNU44xrRqSK7FUTmKozs/pc/sfVnXfr0LFyCUWErU2dGZH1ix9yb+vOBceAwHy37j
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0753;6:R5D3SjAHqo2zv8FH+VupRdUO9rK7A+y8dekwGaTDbPYoZpcp9ZO0IMhKDv99U1T/nxk/WjzK+ObNHoH+RQOLV61OKhu6H/fbolY291EdqqK2PXwhLs7XxNlXiJ30eTTTVti6sZJzu/FeecosVt4EaYTx69YuJkitLRRjR/JlzKVe4iqjpV476YVdzhMqRA8v+74xhCBsmKWE39vej+ctw+r/ov+saLLU09ag83c72E1Ik35e1SkL6DrG6TK8t48HkyR7RZF8q+ZBVoA6EB9/y/QyNQrOB8/Gddwb+P0dWQvokoLX7ivhQ667TK15P2/6w6162bO3Ne3YVU9i4o/6BCds5X76XaBc35R9z/+Gpd7kYHRNejMgkshqEWqxQVWJgyFS5BdbM2PkVZK9UJUJi83k/RWutkNu0Bcsz4PnatUZ8xuBJJSvIUde67LVGITAPcEvmBZqf7lSOuO8GT+PYw==;5:h6Cb8NPttHkxdFgG7jO0GmJsvf/+WNZQ3S6aMCegSKCxoyg/+LyQQYqO58XDMyB+m7buap7/Tx4KwdJANeMkiEMkC9E8OlHEObBUxTcrX7D/Qbu+dj1AmB6ocdasJUV4ZUM0MbHqFxMpFRbuVrl8YnokisjlMaOHEd9MS+2V7Y8=;24:jDfDM1hkQ9Bu0pB6IvP3pHTsDaKmj1z2NpZUXlgqdfy0DXNoXQ0TSdNkEygQCJv/P73p3MqZkksXLpLRuGXYso65zSCFAhrB4gK3ANJgSJk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0753;7:BsdNIjjKWJAIKAbvJBNwF0P4mNG+NtSgQtNLJwkCyxoo+PAILWdLAhmxLIBKsq+h/droLfWahShGPtp1ImQqIUTAMYtNS3gmJa72RNcAYVn9RM+HoI0zPWThGiSJXSkyz3H/0XGM5mryBO3SnCBcpifoTPJE7D9s1T09EvryyRnPyanQDcyeMKYRSBM40isfi6DKCG4V4D1sOUasV1SPWvJdCPEeXbKcgTWabaGYoesYbiBsU+acNNf8mNA6X3BU;20:c1cpEaYF/NacuBgE+XT622yQobAT7M6RoefpTCB0bCowrqk6McxRoZmXpMUQdSa3wA9iCDBj6UMZNt1HTDy8Dbmrrxcp8sWjFr5+pHM9AAjLKJDgCODXmZUQeZUeb00pA/EAWZy7uDCfF1qhlsTtWxZ07WHAssa5N2zVUPrS6StLBcJBLssa57Joyg0OYuGUJ7f6STaBoo/dxJVdUjnvTDOyneh57FlJ+YCC6pqhZBLKr+AD2N0sTha5hvXCzd4Z
X-MS-Office365-Filtering-Correlation-Id: c439b9dd-65a7-4ef4-46d5-08d5a9f88a38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:32:07.5595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c439b9dd-65a7-4ef4-46d5-08d5a9f88a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0753
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid calling wait_event_killable when you are possibly being called
from get_signal routine since in that case you end up in a deadlock
where you are alreay blocked in singla processing any trying to wait
on a new signal.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
index 088ff2b..09fd258 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
@@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
 		return;
 	/**
 	 * The client will not queue more IBs during this fini, consume existing
-	 * queued IBs or discard them on SIGKILL
+	 * queued IBs or discard them when in death signal state since
+	 * wait_event_killable can't receive signals in that state.
 	*/
-	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
+	if (current->flags & PF_SIGNALED)
 		entity->fini_status = -ERESTARTSYS;
 	else
 		entity->fini_status = wait_event_killable(sched->job_scheduled,
-- 
2.7.4
