Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA111C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BA025B32
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BA025B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965378AbeFZDe1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:34:27 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:20049 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965309AbeFZDe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:34:26 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 26 Jun 2018 13:04:23 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fXekH-0006Kl-At
        for linux-kernel@vger.kernel.org; Tue, 26 Jun 2018 13:34:21 +1000
Date:   Tue, 26 Jun 2018 13:34:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org
Subject: [BUG? v4.16.12] OOM kill of qemu causes whacky pty shenanigans
Message-ID: <20180626033421.GI13748@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI folks,

I've come across a strange problem recently when doing some MPI
based CPU+IO load test simulations recently. I've been running them
on the same machine I use to host all my filesystem test VMs
(16p/32t, 64GB RAM) which is currently running 4.16.12.  Both the
MPI job context and the qemu VM contexts are run from inside
separate, unrelated ssh + screen sessions.

When I size the MPI job large enough (18 million cells in the mesh
for the CFD simulation requires about 45GB of RAM) it runs the host
out of memory and the OOM killer picks the largest VM (32GB RAM) to
kill as it doesn't track the MPI job as a single memory hog. The OOM
kill message is nothing unusual:


[1042458.854842] snappyHexMesh invoked oom-killer: gfp_mask=0x14200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null), order=0, oom_score_adj=0
[1042458.868065] snappyHexMesh cpuset=session-1.scope mems_allowed=0-1
[1042458.875088] CPU: 12 PID: 39442 Comm: snappyHexMesh Not tainted 4.16.0-2-amd64 #1 Debian 4.16.12-1
[1042458.885182] Hardware name: Dell Inc. PowerEdge R820/0YWR73, BIOS 1.5.0 03/08/2013
[1042458.893727] Call Trace:
[1042458.896658]  dump_stack+0x5c/0x85
[1042458.900552]  dump_header+0x6b/0x289
[1042458.904632]  ? apparmor_capable+0xa4/0xe0
[1042458.909301]  ? cap_inode_getsecurity+0x220/0x220
[1042458.914644]  oom_kill_process+0x228/0x470
[1042458.919311]  out_of_memory+0x2ab/0x4b0
[1042458.923686]  __alloc_pages_slowpath+0x9f2/0xd80
[1042458.928936]  __alloc_pages_nodemask+0x236/0x250
[1042458.934184]  filemap_fault+0x1f9/0x630
[1042458.938562]  ? page_add_file_rmap+0x109/0x200
[1042458.943618]  ? alloc_set_pte+0x452/0x500
[1042458.948190]  ? _cond_resched+0x15/0x40
[1042458.952618]  __xfs_filemap_fault+0x72/0x200 [xfs]
[1042458.958062]  __do_fault+0x1f/0xb0
[1042458.961953]  __handle_mm_fault+0xca6/0x1220
[1042458.966815]  handle_mm_fault+0xdc/0x210
[1042458.971290]  __do_page_fault+0x256/0x4e0
[1042458.975860]  ? page_fault+0x2f/0x50
[1042458.979942]  page_fault+0x45/0x50
[1042458.983834] RIP: 425e80c0:0x7ffe648cb690
[1042458.988401] RSP: 0018:000000000006aee0 EFLAGS: 55f1425e80b0
[1042458.988416] Mem-Info:
[1042458.997564] active_anon:14864071 inactive_anon:1334793 isolated_anon:0
                  active_file:2 inactive_file:49 isolated_file:0
                  unevictable:0 dirty:5 writeback:0 unstable:0
                  slab_reclaimable:28879 slab_unreclaimable:51679
                  mapped:82 shmem:117 pagetables:41302 bounce:0
                  free:55214 free_pcp:503 free_cma:0
[1042459.035688] Node 0 active_anon:29395060kB inactive_anon:2795292kB active_file:48kB inactive_file:104kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:160kB dirty:0kB writeback:0kB shmem:324kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 19171328kB writeback_tmp:0kB unstable:0kB all_unreclaimable? yes
[1042459.067024] Node 1 active_anon:30061224kB inactive_anon:2543880kB active_file:0kB inactive_file:152kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:164kB dirty:20kB writeback:0kB shmem:144kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 13232128kB writeback_tmp:0kB unstable:0kB all_unreclaimable? yes
[1042459.098359] Node 0 DMA free:15880kB min:20kB low:32kB high:44kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15980kB managed:15896kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[1042459.127285] lowmem_reserve[]: 0 3174 32097 32097 32097
[1042459.133225] Node 0 DMA32 free:119936kB min:4444kB low:7692kB high:10940kB active_anon:2734924kB inactive_anon:416452kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3345344kB managed:3279776kB mlocked:0kB kernel_stack:0kB pagetables:4kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[1042459.164576] lowmem_reserve[]: 0 0 28922 28922 28922
[1042459.170225] Node 0 Normal free:40080kB min:40504kB low:70120kB high:99736kB active_anon:26660136kB inactive_anon:2378840kB active_file:48kB inactive_file:104kB unevictable:0kB writepending:0kB present:30146560kB managed:29616592kB mlocked:0kB kernel_stack:6808kB pagetables:82392kB bounce:0kB free_pcp:1680kB local_pcp:124kB free_cma:0kB
[1042459.203605] lowmem_reserve[]: 0 0 0 0 0
[1042459.208094] Node 1 Normal free:44960kB min:45136kB low:78136kB high:111136kB active_anon:30061224kB inactive_anon:2544016kB active_file:0kB inactive_file:224kB unevictable:0kB writepending:4kB present:33554432kB managed:33005280kB mlocked:0kB kernel_stack:4520kB pagetables:82812kB bounce:0kB free_pcp:388kB local_pcp:28kB free_cma:0kB
[1042459.241274] lowmem_reserve[]: 0 0 0 0 0
[1042459.245756] Node 0 DMA: 0*4kB 1*8kB (U) 0*16kB 0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15880kB
[1042459.260531] Node 0 DMA32: 26*4kB (UM) 33*8kB (UM) 25*16kB (UM) 110*32kB (UME) 79*64kB (UME) 48*128kB (UME) 26*256kB (UME) 13*512kB (UME) 9*1024kB (UME) 2*2048kB (E) 19*4096kB (M) = 119936kB
[1042459.279573] Node 0 Normal: 1790*4kB (UE) 908*8kB (UME) 342*16kB (UE) 353*32kB (UME) 96*64kB (UE) 24*128kB (UME) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 40408kB
[1042459.296187] Node 1 Normal: 425*4kB (UE) 220*8kB (UME) 1180*16kB (UME) 548*32kB (UME) 62*64kB (UE) 4*128kB (M) 3*256kB (M) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 45124kB
[1042459.313003] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[1042459.322913] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[1042459.332530] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[1042459.342437] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[1042459.352057] 41687 total pagecache pages
[1042459.356538] 41489 pages in swap cache
[1042459.360825] Swap cache stats: add 4260227, delete 4218691, find 592509/664249
[1042459.368988] Free swap  = 0kB
[1042459.372399] Total swap = 3905532kB
[1042459.376392] 16765579 pages RAM
[1042459.379999] 0 pages HighMem/MovableOnly
[1042459.384478] 286193 pages reserved
[1042459.388378] 0 pages hwpoisoned
[1042459.391985] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[1042459.401652] [  763]     0   763    12223      112   118784      600         -1000 systemd-udevd
[1042459.411561] [ 1968]     0  1968     5145       58    69632      210             0 dhclient
[1042459.420987] [ 2400]     0  2400    13034       15   139264      113             0 rpcbind
[1042459.430316] [ 2428]   105  2428     8889        0   106496      200             0 rpc.statd
[1042459.439844] [ 2462]     0  2462     5881        0    90112       50             0 rpc.idmapd
[1042459.449464] [ 2606]     0  2606     6904        1    90112       53             0 acpi_fakekeyd
[1042459.459376] [ 2638]     0  2638    10695       51   131072       51             0 cgmanager
[1042459.468900] [ 2808]     0  2808     7033        0    94208       56             0 lvmetad
[1042459.478229] [ 2851]     0  2851    66834      183   167936      257             0 rsyslogd
[1042459.487658] [ 2903]     0  2903    69837      124   299008      235             0 cups-browsed
[1042459.497475] [ 2967]     0  2967     1113        1    53248       61             0 acpid
[1042459.506602] [ 3003]     0  3003     3903       12    73728       60             0 mdadm
[1042459.515740] [ 3055]     0  3055     9727       68   110592       76             0 irqbalance
[1042459.525358] [ 3122]     0  3122     7022        5    98304       47             0 atd
[1042459.534299] [ 3240]     0  3240    18055       32   176128      163         -1000 sshd
[1042459.543339] [ 3259]   102  3259    11939      156   131072       63             0 dbus-daemon
[1042459.553051] [ 3349]     0  3349    14556        0   147456      127             0 bluetoothd
[1042459.562673] [ 3552]   106  3552    12360       71   139264       50             0 avahi-daemon
[1042459.572485] [ 3555]   106  3555    12327        9   135168       81             0 avahi-daemon
[1042459.582297] [ 3677]   110  3677    26233       50   126976       97             0 ntpd
[1042459.591335] [ 3829]   104  3829    16274       13   159744      192             0 exim4
[1042459.600473] [ 3859]   999  3859    11014        0   126976       92             0 pmproxy
[1042459.609799] [ 3870]   999  3870    13168       67   147456       92             0 pmcd
[1042459.618843] [ 3947]     0  3947    11586        9   131072       87             0 pmdaproc
[1042459.628275] [ 3951]     0  3951     9448       25   114688       66             0 pmdaxfs
[1042459.637606] [ 3952]     0  3952     9542       57   126976       66             0 pmdalinux
[1042459.647132] [ 4140]     0  4140    57236       86   471040      387             0 nmbd
[1042459.656173] [ 4142]   999  4142    11060       39   122880       82             0 pmie
[1042459.665202] [ 4162]     0  4162    69652      119   561152      446             0 winbindd
[1042459.674629] [ 4211]     0  4211     7446       26   102400       47             0 cron
[1042459.683669] [ 4237]     0  4237    71223      113   581632      453             0 winbindd
[1042459.693096] [ 4238]     0  4238    80439      157   655360      526             0 smbd
[1042459.702135] [ 4244]     0  4244    78409       72   614400      553             0 smbd-notifyd
[1042459.711947] [ 4246]     0  4246    78409       73   610304      551             0 cleanupd
[1042459.721368] [ 4262]     0  4262    69652       88   557056      471             0 winbindd
[1042459.730790] [ 4267]     0  4267     3661        0    69632       38             0 getty
[1042459.739921] [ 4268]     0  4268     3661        0    69632       35             0 getty
[1042459.749079] [ 4269]     0  4269     3661        0    73728       35             0 getty
[1042459.758246] [ 4270]     0  4270     3661        0    69632       37             0 getty
[1042459.767375] [ 4271]     0  4271     3661        0    77824       37             0 getty
[1042459.776525] [ 4272]     0  4272     3661        0    69632       36             0 getty
[1042459.785669] [ 4273]     0  4273     3194        0    69632       36             0 getty
[1042459.794799] [ 4274]     0  4274    69652       91   565248      471             0 winbindd
[1042459.804247] [ 4275]     0  4275    80439      119   626688      543             0 lpqd
[1042459.813308] [ 4303]     0  4303    30168        5   278528      270             0 sshd
[1042459.822344] [ 4306]     0  4306    16499       86   159744      109             0 systemd-logind
[1042459.832350] [ 4319]     0  4319  1069129      248   450560      156             0 console-kit-dae
[1042459.842463] [ 4386]     0  4386    72169      223   204800        7             0 polkitd
[1042459.851796] [ 4397]  1000  4397    30168       29   274432      250             0 sshd
[1042459.860853] [ 4398]  1000  4398     5378       81    86016      441             0 bash
[1042459.869916] [ 4410]  1000  4410     2799        1    61440       83             0 ssh-agent
[1042459.879435] [ 4542]     0  4542    30168      266   270336        9             0 sshd
[1042459.888488] [ 4559]  1000  4559    30203      320   270336       19             0 sshd
[1042459.897527] [ 4560]  1000  4560     5425      376    86016      194             0 bash
[1042459.906562] [ 4574]  1000  4574     2799        1    61440       82             0 ssh-agent
[1042459.916102] [ 4795]  1000  4795    12564       51   131072       59             0 dbus-launch
[1042459.925814] [ 4796]  1000  4796    11825       62   126976       47             0 dbus-daemon
[1042459.935517] [14647]     0 14647    30168       91   294912      183             0 sshd
[1042459.944552] [14664]  1000 14664    30168      122   286720      163             0 sshd
[1042459.953600] [14665]  1000 14665     5440      413    90112      170             0 bash
[1042459.962641] [14677]  1000 14677     2799       31    65536       55             0 ssh-agent
[1042459.972198] [14686]     0 14686    30168       91   278528      182             0 sshd
[1042459.981258] [14703]  1000 14703    30215      118   270336      231             0 sshd
[1042459.990306] [14704]  1000 14704     5347       49    81920      441             0 bash
[1042459.999353] [14716]  1000 14716     2799       32    61440       55             0 ssh-agent
[1042460.008886] [32274]     0 32274    30168      251   278528       24             0 sshd
[1042460.017932] [32291]  1000 32291    30168      226   274432       55             0 sshd
[1042460.026973] [32292]  1000 32292     5347        5    81920      485             0 bash
[1042460.036007] [32304]  1000 32304     2799        5    61440       81             0 ssh-agent
[1042460.045525] [32311]  1000 32311     7473       12    94208       53             0 screen
[1042460.054753] [32312]  1000 32312     7934      246    94208      301             0 screen
[1042460.063979] [32313]  1000 32313     5377       29    81920      492             0 bash
[1042460.073006] [32330]  1000 32330     5356        2    86016      497             0 bash
[1042460.082054] [32344]  1000 32344     5356       50    86016      450             0 bash
[1042460.091102] [32413]     0 32413    21253        1   204800      185             0 sudo
[1042460.100149] [32420]     0 32420     5091      618    81920      321             0 minicom
[1042460.109502] [20059]  1000 20059     5356       44    90112      456             0 bash
[1042460.118548] [44723]  1000 44723     1099        3    57344       14             0 run-vm-2.sh
[1042460.128273] [44724]     0 44724    21253       21   212992      167             0 sudo
[1042460.137327] [44725]     0 44725  1521408   129371  4300800   228831             0 qemu-system-x86
[1042460.147427] [44793]  1000 44793    12715        0   135168      185             0 ssh
[1042460.156363] [38541]     0 38541    30168      275   278528        0             0 sshd
[1042460.165399] [38558]  1000 38558    30192      329   270336        0             0 sshd
[1042460.174447] [38559]  1000 38559     5347      490    81920        0             0 bash
[1042460.183486] [38571]  1000 38571     2799       84    57344        0             0 ssh-agent
[1042460.193011] [45612]  1000 45612     7473        8    98304       56             0 screen
[1042460.202240] [45613]  1000 45613     7778      362    98304       46             0 screen
[1042460.211472] [45614]  1000 45614     5380      480    86016       44             0 bash
[1042460.220512] [45631]  1000 45631     5356      144    86016      355             0 bash
[1042460.229544] [45715]  1000 45715     5356      102    86016      398             0 bash
[1042460.238582] [48358]  1000 48358     7473       64    98304        0             0 screen
[1042460.247812] [48359]  1000 48359     7679      234    94208       78             0 screen
[1042460.257044] [48360]  1000 48360     5378      204    77824      318             0 bash
[1042460.266081] [48485]  1000 48485     5379      115    86016      408             0 bash
[1042460.275119] [ 2083]  1000  2083     1099       17    49152        0             0 run-vm-4.sh
[1042460.284834] [ 2084]     0  2084    21253      187   204800        0             0 sudo
[1042460.293878] [ 2085]     0  2085  9056612  7328849 67842048   733666             0 qemu-system-x86
[1042460.303985] [ 2148]     0  2148    21253      143   200704       42             0 sudo
[1042460.313023] [ 2149]     0  2149     5091      939    86016        0             0 minicom
[1042460.322355] [ 3149]  1000  3149    12715      180   139264        0             0 ssh
[1042460.331303] [21924]     0 21924    25953      315   233472        0             0 cupsd
[1042460.340440] [21925]     7 21925    22741      212   208896        0             0 dbus
[1042460.349484] [37045]  1000 37045   418582     2889   811008        0             0 gnuplot_qt
[1042460.359105] [39380]  1000 39380     1099       26    57344        2             0 run
[1042460.368045] [39432]  1000 39432     1039       16    49152        0             0 time
[1042460.377082] [39433]  1000 39433   110922      866   458752      107             0 mpirun
[1042460.386321] [39438]  1000 39438   720715   556516  5165056        2             0 snappyHexMesh
[1042460.396249] [39439]  1000 39439   763916   600078  5509120        0             0 snappyHexMesh
[1042460.406183] [39440]  1000 39440   689492   527822  4935680        3             0 snappyHexMesh
[1042460.416102] [39441]  1000 39441   704591   534960  4988928        0             0 snappyHexMesh
[1042460.426020] [39442]  1000 39442   686596   525003  4911104        0             0 snappyHexMesh
[1042460.435932] [39443]  1000 39443   708465   540795  5050368        0             0 snappyHexMesh
[1042460.445859] [39444]  1000 39444   707042   542633  5079040        0             0 snappyHexMesh
[1042460.455785] [39445]  1000 39445   659332   504386  4714496        0             0 snappyHexMesh
[1042460.465703] [39446]  1000 39446   704596   543388  5058560        0             0 snappyHexMesh
[1042460.475610] [39447]  1000 39447   749776   589496  5414912        0             0 snappyHexMesh
[1042460.485518] [39448]  1000 39448   689231   527595  4960256        0             0 snappyHexMesh
[1042460.495425] [39449]  1000 39449   713167   544591  5107712        0             0 snappyHexMesh
[1042460.505342] [39450]  1000 39450   691005   526423  4964352        0             0 snappyHexMesh
[1042460.515269] [39451]  1000 39451   709333   548432  5087232        0             0 snappyHexMesh
[1042460.525195] [39455]  1000 39455   728685   567434  5242880        0             0 snappyHexMesh
[1042460.535113] [39460]  1000 39460   659692   504657  4747264        0             0 snappyHexMesh
[1042460.545032] [39639]  1000 39639     1496       16    49152        0             0 tail
[1042460.554082] [40142]   999 40142    11035       90   126976        0             0 pmlogger
[1042460.563518] Out of memory: Kill process 2085 (qemu-system-x86) score 448 or sacrifice child
[1042460.573109] Killed process 2085 (qemu-system-x86) total-vm:36226448kB, anon-rss:29315388kB, file-rss:0kB, shmem-rss:8kB
[1042461.371498] oom_reaper: reaped process 2085 (qemu-system-x86), now anon-rss:0kB, file-rss:132kB, shmem-rss:8kB

But now the problems start.

The first symptom is that the MPI meshing job doesn't complete - the
parent mpirun process that waits for all the children in poll()
never returns when all the children exit. I don't have a stack trace
close handy for that (on a different machine) but I can get one if
necessary.

However, I can 'killall mpirun' once I know the children have
completed (from the log file) and it exits just fine and moves on to
the next stage of the computation. This runs more MPI jobs and they
also hang in the same way - whatever has gone wrong persists across
to new MPI jobs.

The second symptom is that after the OOM kill, running dmesg inside
the VM screen session loses random lines of output and often
terminates prematurely like:

.....
[761643.926907] [24832]  1000 24832   662113   512671  4812800          0             0 snappyHexMesh
[761643.936744] [24833]  1000 24833   701140   550286  5128192         0             0 snappyHexMesh
dmesg: write error
$

This also corresponds with different terminals within the screen
session losing character input - no echo comes back to key presses,
and sometimes I have ot repeat a key press 5 times before I get an
echo. This seems to only happen inside the VM screen session.

First time it happened, I ended up rebooting the machine to fix the
problem. Second time it happened, I correlated the OOM killer being
invoked with the problem showing up. Third time it happened, I
noticed something really whacky with various ptys.

Inside the VM screen session, I first noticed that stracing the
dmesg invocation made the output problems go away. I then noticed
that inside the 'minicom -d /dev/pts/<n>' process which was
connected to the now dead VM console, the character input that was
going missing from other session contexts was being /echoed by the
minicom terminal/. Because the VM was dead and I had not created any
new sessions since the OOM kill, that terminal should not have been
connected to anything any more. However, somehow it was swallowing
input from other ptys that were not associated with the VM that died
and connected before both the VM and minicom was started...

Shutting down minicom didn't fix the problems. MPI jobs still hung,
sessions inside screen sessions still played up. So I shut down
the VM screen session, leaving the underlying ssh session connected.
New MPI jobs still hung.

So through a process of elimination, I found that when I exited all
the screen and ssh sessions that were ancestors of the processes
involved in the OOM killer invocation, the problem with the
terminals went away and MPI jobs stopped hanging. ie. new ssh+screen
sessions weren't enough to make the problems go away - all the old
sessions had to go away before symptoms disappeared and everything
behaved normally again.

Until, of course, the OOM killer kicked in again and killed the Big
Test VM. And then exactly the same problem occurs. The resolution is
identical - log out of all the screen+ssh sessions involved in the
mpi job and VM that was killed, and the problem goes away.

I've got no idea how to track this down. Cross-talk between
different ptys should never occur, and killing a process should not
screw up processes and ptys in completely different contexts. But
something is clearly getting screwed up and the trigger is an OOM
kill event.

Anyone got any ideas on how to go about debugging this?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
