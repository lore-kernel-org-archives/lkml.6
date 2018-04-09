Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDIWdr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:33:47 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:58192 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751367AbeDIWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:33:45 -0400
From: "Banerjee, Debabrata" <dbanerje@akamai.com>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@free.fr>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: RE: [PATCH] Fix /proc/[pid]/ns permissions
Thread-Topic: [PATCH] Fix /proc/[pid]/ns permissions
Thread-Index: AQHTzRK08q964ToipEaE4cfAyhm29KP5B9IA
Date: Mon, 9 Apr 2018 22:33:37 +0000
Message-ID: <84eac68c566948ce8939351b6c249343@usma1ex-dag1mb2.msg.corp.akamai.com>
References: <20180405171502.14347-1-dbanerje@akamai.com>
        <31CF3F25-8A82-426B-BFA0-6225C39334F5@akamai.com>
 <87h8op79ac.fsf@xmission.com>
In-Reply-To: <87h8op79ac.fsf@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.28.122.90]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804090224
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804090224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w39MXsdh013273

> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
>
> I agree there is an inconsistency on the directory permissions for the ns
> directory that could reasonably be fixed.

So you'd recommend taking this patch as-is?

> prctl(PR_SET_DUMPABLE, 0) is an interesting.  Fundamentally it is about not
> letting unprivileged tasks poke about with the process, and it is the
> mechanism used by setuid/setgid exec.   If you are root in the user
> namespace of the task or your uid created the user namespace or an
> ancestor user namespace you should be able to inspect the process.
> 
> What happens with dumpable is also going to vary a little bit depending on
> how recent your kernel is.  The dumpable status was not really namespaced
> until recently.
> 
> There might also be some issues from yama or other lsms that love to limit
> ptrace.  Though it sounds like your issue is the dumpability.
> 
> The check "ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)" is the
> standard check for accessing anything even a little bit sensitive of a process,
> and that seems appropriate here.

Why is the namespace inode # secret? If it is because it's an inode, perhaps there is a better way to represent the namespace that is not secret? What we are trying to do is check if link points to the same place as our namespace, the contents don't matter. On the other hand it would be very convenient if pid's not in your namespace, even from a parent namespace, did not appear. That would make user tools work properly without workarounds, i.e. killall, pgrep, ps, top.
