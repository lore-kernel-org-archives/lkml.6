Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935208AbeBLNOg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:14:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933655AbeBLNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:14:33 -0500
To: Oleg Nesterov <oleg@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        ananth@linux.vnet.ibm.com, lkml <linux-kernel@vger.kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Uprobe: Bug(?) when probing small binaries
Date: Mon, 12 Feb 2018 18:46:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18021213-0008-0000-0000-000004CBE7BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021213-0009-0000-0000-00001E5FA53F
Message-Id: <e74318e0-0cdf-e55d-bf06-b481541e2697@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

I'm observing a bug in the uprobe infrastructure. When target binary
is quite small, uprobe replaces 'trap' instruction at two different
places. Ex,

Simple test.c that loops for 100 seconds:

    void main()
    {
        int i = 0;
   
        while (i++ != 100) {
            printf("hi: %d", i);
            sleep(1);
        }
    }

Add a probe on function main() in test.c

  $ perf probe -x ./a.out main
    Added new event:
      probe_a:main          (on main in /home/ravi/a.out)

Start the target program and pause it.

  $ gdb --args ./a.out
    (gdb) r
    main: 1
    main: 2
    ^C

  (gdb) disassemble main
       0x000000001000069c <+8>:    mflr    r0
 
  (gdb) x/w 0x1001069c
    0x1001069c:    2080899750

Now enable the probe:

  # echo 1 > events/probe_a/main/enable

Check probed instruction:

  (gdb) disassemble main
       0x000000001000069c <+8>:    trap

*Bug*:

  (gdb) x/w 0x1001069c
    0x1001069c:  2145386504

In short, when it replaces the probe instruction, it does some corruption
in the readonly vma. This seems to be a bug.

How did I get the other address 0x1001069c?I found build_map_info()
returns these two vmas for the single probe:

  10000000-10010000 r-xp 00000000 08:05 67325595   /home/ravi/a.out
  10010000-10020000 r--p 00000000 08:05 67325595   /home/ravi/a.out

and thusregister_for_each_vmas() calls install_breakpoint() on both of
thesevmas with different vaddr.

The example is on powerpc but same issue is observed on x86 as well. As,
the code is common, it should be reproducible on every architecture.

Also, I don't observe this issue for bigger binaries (maybe for those
whose vma spans across multiple pages).

Thanks,
Ravi
