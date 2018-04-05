Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDESXY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:23:24 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:51578 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbeDESXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:23:23 -0400
From: "Banerjee, Debabrata" <dbanerje@akamai.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
CC: Daniel Lezcano <daniel.lezcano@free.fr>
Subject: Re: [PATCH] Fix /proc/[pid]/ns permissions
Thread-Topic: [PATCH] Fix /proc/[pid]/ns permissions
Thread-Index: AQHTzQGo8q964ToipEaE4cfAyhm29KPyfFEA
Date: Thu, 5 Apr 2018 18:23:16 +0000
Message-ID: <31CF3F25-8A82-426B-BFA0-6225C39334F5@akamai.com>
References: <20180405171502.14347-1-dbanerje@akamai.com>
In-Reply-To: <20180405171502.14347-1-dbanerje@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.32.61]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1C3247102B7F4687F60BBB7B2F458D@akamai.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804050186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w35INUWt028293

Actually, this patch is incomplete. proc_ns_get_link() and proc_ns_readlink() gate on ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS). I'm not sure why this is here either. It seems problematic that after a user creates a pid namespace, that a user cannot tell anymore which namespace new pids belongs to, including the parent namespace after prctl(). Some mechanism is required here. If ns->inum from ns_get_name() is secret, then at least a flag if it is in your namespace.

-Deb

﻿On 4/5/18, 1:15 PM, "Debabrata Banerjee" <dbanerje@akamai.com> wrote:

    This seems like a bug since the original commit 6b4e306aa3dc. Having ns
    directory be executable but not readable does not make sense. Further,
    it breaks userspace when it needs to know which namespace it belongs
    to. For example, setting a process to prctl(PR_SET_DUMPABLE, 0)
    immediately hides the namespace from that user, breaking the latest
    pgrep with namespace support.
    
    The main problem here is that unlike other namespaces, pid namespaces
    appear flat as you follow the parents upwards in the heirarchy. It is
    important to be able to tell that a process is in your namespace, a
    child namespace, or an entirely different namespace. In the latter
    case, the pid is already hidden from you, thus these permission don't
    matter.
    
    CC: Eric W. Biederman <ebiederm@xmission.com>
    CC: Daniel Lezcano <daniel.lezcano@free.fr>
    
    Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
    ---
     fs/proc/base.c | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/fs/proc/base.c b/fs/proc/base.c
    index d53246863cfb..2295ac0d8e1c 100644
    --- a/fs/proc/base.c
    +++ b/fs/proc/base.c
    @@ -2922,7 +2922,7 @@ static const struct pid_entry tgid_base_stuff[] = {
     	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
     	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
     	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
    -	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
    +	DIR("ns",	  S_IRUGO|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
     #ifdef CONFIG_NET
     	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
     #endif
    -- 
    2.16.2
    
    
