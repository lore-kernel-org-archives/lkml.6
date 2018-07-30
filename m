Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C717F13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150CC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150CC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeG3Jp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:45:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:2381 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeG3Jpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:45:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 01:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="gz'50?scan'50,208,50";a="58210453"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2018 01:11:43 -0700
Date:   Mon, 30 Jul 2018 16:12:19 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] 7acf9d4237 BUG: kernel hang in test stage
Message-ID: <20180730081219.GC30690@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

commit 7acf9d4237c46894e0fa0492dd96314a41742e84
Author:     Dmitry Safonov <dima@arista.com>
AuthorDate: Fri Jul 27 16:54:44 2018 +0100
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Sun Jul 29 12:50:19 2018 -0700

    netlink: Do not subscribe to non-existent groups
    
    Make ABI more strict about subscribing to group > ngroups.
    Code doesn't check for that and it looks bogus.
    (one can subscribe to non-existing group)
    Still, it's possible to bind() to all possible groups with (-1)
    
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Herbert Xu <herbert@gondor.apana.org.au>
    Cc: Steffen Klassert <steffen.klassert@secunet.com>
    Cc: netdev@vger.kernel.org
    Signed-off-by: Dmitry Safonov <dima@arista.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

9939a46d90  NET: stmmac: align DMA stuff to largest cache line length
7acf9d4237  netlink: Do not subscribe to non-existent groups
25432eba9c  openvswitch: meter: Fix setting meter id for new entries
+--------------------------------------------------+------------+------------+------------+
|                                                  | 9939a46d90 | 7acf9d4237 | 25432eba9c |
+--------------------------------------------------+------------+------------+------------+
| boot_successes                                   | 20         | 4          | 4          |
| boot_failures                                    | 22         | 11         | 11         |
| INFO:task_blocked_for_more_than#seconds          | 22         |            |            |
| Kernel_panic-not_syncing:hung_task:blocked_tasks | 22         |            |            |
| BUG:kernel_hang_in_test_stage                    | 0          | 11         | 11         |
+--------------------------------------------------+------------+------------+------------+

[ 1414.113020] Writes:  Total: 373492244  Max/Min: 0/0   Fail: 0 
[ 1472.149785] CE: Reprogramming failure. Giving up
[ 1475.552294] Writes:  Total: 387526813  Max/Min: 0/0   Fail: 0 
[ 1509.501097] CE: Reprogramming failure. Giving up
[ 1536.992336] Writes:  Total: 403788741  Max/Min: 0/0   Fail: 0 
BUG: kernel hang in test stage


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 0a930dcfc77cb12bbf9bffd69fbadcb0c237f577 d72e90f33aa4709ebecc5005562f52335e106a60 --
git bisect  bad f605359102be537b6217dc49600f4369d1f04932  # 07:19  B      0    11   27   0  Merge 'm68k/master' into devel-catchup-201807300507
git bisect  bad 375347c493a490f493fafa02f30fa23179acbdb9  # 07:53  B      0    11   27   0  Merge 'linux-review/Todd-Poynor/staging-gasket-fixes-and-cleanups/20180730-034316' into devel-catchup-201807300507
git bisect good 86b34080126c3f4254a3f9e8d5dcb447d9233bc8  # 08:05  G     11     0    6   6  0day base guard for 'devel-catchup-201807300507'
git bisect  bad ed28433e6f289d33dd6b4bbf627a60396234db58  # 08:40  B      0     1   17   0  Merge 'net/master' into devel-catchup-201807300507
git bisect good 5b891af7fca14526b2a87c6f38b004e2df655ef4  # 08:54  G     11     0   11  11  bpf: Replace [u]int32_t and [u]int64_t in libbpf
git bisect good c259b4fb33ee6e7667bf1d34bf0803b7c5fdbdce  # 09:03  G     10     0    3   3  netdevsim: don't leak devlink resources
git bisect good b0753408aadf32c7ece9e6b765017881e54af833  # 09:17  G     11     0    3   3  net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
git bisect good 71eb5255f55bdb484d35ff7c9a1803f453dfbf82  # 09:25  G     11     0   11  11  bpf: use GFP_ATOMIC instead of GFP_KERNEL in bpf_parse_prog()
git bisect good 6d27c6dd1012e7be748ec05da78556319718fbe7  # 09:39  G     11     0    4   4  Merge branch 'net-socket-Fix-potential-spectre-v1-gadgets'
git bisect good 9939a46d90c6c76f4533d534dbadfa7b39dc6acc  # 09:55  G     11     0    7   7  NET: stmmac: align DMA stuff to largest cache line length
git bisect  bad 25432eba9cd8f2ef5afef55be811b010a004b5fa  # 10:28  B      0    11   27   0  openvswitch: meter: Fix setting meter id for new entries
git bisect  bad 7acf9d4237c46894e0fa0492dd96314a41742e84  # 11:03  B      0     6   22   0  netlink: Do not subscribe to non-existent groups
# first bad commit: [7acf9d4237c46894e0fa0492dd96314a41742e84] netlink: Do not subscribe to non-existent groups
git bisect good 9939a46d90c6c76f4533d534dbadfa7b39dc6acc  # 11:14  G     31     0   15  22  NET: stmmac: align DMA stuff to largest cache line length
# extra tests with debug options
git bisect  bad 7acf9d4237c46894e0fa0492dd96314a41742e84  # 11:48  B      0    11   27   0  netlink: Do not subscribe to non-existent groups
# extra tests on HEAD of linux-devel/devel-catchup-201807300507
git bisect  bad 0a930dcfc77cb12bbf9bffd69fbadcb0c237f577  # 11:49  B      0    13   31   0  0day head guard for 'devel-catchup-201807300507'
# extra tests on tree/branch net/master
git bisect  bad 25432eba9cd8f2ef5afef55be811b010a004b5fa  # 11:50  B      0    11   27   0  openvswitch: meter: Fix setting meter id for new entries
# extra tests with first bad commit reverted
git bisect good e61543e57747e8fd80390af39504365a392cef2b  # 12:04  G     11     0    4   4  Revert "netlink: Do not subscribe to non-existent groups"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--IDYEmSnFhs3mNXr+
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-14:20180730110424:i386-randconfig-sb0-07300301:4.18.0-rc6-00133-g7acf9d4:1.gz"
Content-Transfer-Encoding: base64

H4sICEaOXlsAA2RtZXNnLXlvY3RvLXZwLTE0OjIwMTgwNzMwMTEwNDI0OmkzODYtcmFuZGNv
bmZpZy1zYjAtMDczMDAzMDE6NC4xOC4wLXJjNi0wMDEzMy1nN2FjZjlkNDoxALxc63PbOJL/
fPdX9Ox8iL0jynxJpLTlq5NlJdbZirWWk8luKqWiSFDmmq/hw7am8sdfN0A9Scmm44yciCKJ
/qHR6G50gwCZlfgLsKMwjXwGXggpy/IYLzjsv78CfuSmzD/f4MoL8yd4YEnqRSHoTcVsylJi
tyVZVjRNmhuW7XYcHY7uZ7nnO//75FnhMRzNbXuDqNPEAudshvfEmaQeH8OvCoxvBoPR+BZG
WOz/ch80GRS5q2ldXYb+5BZUWTF3Oboc3HwcXEGax3GUZMwBO87T7m4pgN7oHHp5dsfCzLPx
pFyij7esPFkeL6zcT8ulbhMrTAOWWfCBhbkXstvRk9k+VG71qz/+VC73adTf/L9bAGm6KLrQ
iZKp58C7otJhmDH/HeThfRg9hg3IUy+cw5yFLPFs7EIva1Yi/SvCBqaLNGMBBNYCZgwx0sya
+axEgM06ceO8CxMhW6rhy6T3eQAus7I8YSA/Ybd34d2TaYDrRxYvEkdemEHC5h7WkqTvXger
IuxkMvhhHB1xep+/vATnCeWQsWnkuqj/X9VvXYCW0W4sr6fenywVl9VWqcNXKIOQhOkUVEte
UmTGaJCNZewpA8ICLwVTU2G2yFi67MF3SBU6VuK8AzdKAqvcjWfD64kUJ9GD52At8d0i9WzL
h5veCDs0Lik+L85MVe7C1wA7nWSy/ZG2LnXcmet+Q26oFbXAOq5dBnMJDJvPkgfm1IJzy7y5
r4dTdpuqqIajuK9pKlGqJbBX8+YylwS3CUeXXg0n0Lbg3OfgHDbL513w5mGUkBb60dxnD8yn
gYDsqqSEHyN0oqwLH7/A0eCJ2Tlq+rnHBXkMqJwZszPy9bYVhlFGXoYJs+hCGIXSuDeAe5aE
zP9lF3kyoraB2jQRB9kNyxZwPhp24Z+D0SeYFMYC4z4cebouv/8Cv8F4OPzSAKXTaR83uKRA
aSpyU5UUkPUTWTnBYUTfBb1YxCgaL40SlAaxT7xefh7tlhNCz2OHjHtH9kuZb6gVnJ7+z16x
C6yEBdHDJpa1xir6rVpFfSvNprEbwinSca1ED/A0tRL7bn2Zl61yVuPebRf6Ueh68zyxeG99
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
8O3XlS0Ny9mgmdjDO5DFE+ftC+JgnwAA

--IDYEmSnFhs3mNXr+
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-13:20180730110848:i386-randconfig-sb0-07300301:4.18.0-rc6-00132-g9939a46:1.gz"
Content-Transfer-Encoding: base64

H4sICECOXlsAA2RtZXNnLXlvY3RvLXZwLTEzOjIwMTgwNzMwMTEwODQ4OmkzODYtcmFuZGNv
bmZpZy1zYjAtMDczMDAzMDE6NC4xOC4wLXJjNi0wMDEzMi1nOTkzOWE0NjoxALxcbXPiSJL+
fPcrcnY+NN5BWK8g2PDFYUy3ORubNe6e3u1wEEIqYa2FpNGLbSb6x19mlXiVwJbbPbgbIany
qcyszKysUpWYFfsLsMMgCX0GXgAJS7MILzjsv78BfuSGzD93cOkF2TM8sjjxwgD0hmI2ZCm2
m5IsK5oqzdptrW3pTag9TDPPd/7Xf4ikp+RZVo+gNrPtDcp2Q4faGZt6Vn4mqUdH8KsCo5t+
fzi6hSEW+7/MB00Gud3RjY6iQ298C6qsmLtsXfRvrvqXkGRRFMYpc8COsqSzWwqgOzyDbpbe
syD1bDwplujhLSuLl8dzK/OTYqnb2AqSOUst+MSCzAvY7fDZbB4qt/rVG30ulvs87G3+3y2A
NB1UXeCE8cRz4ENe6SBImf8BsuAhCJ+COmSJF8xgxgIWeza2o5c2SpH+FaKAySJJ2Rzm1gKm
DDGS1Jr6rECAYh27UdaBsdAt1fB13P3SB5dZaRYzkJ+x7Tvw4dlsgeuHFi8ShV6QQsxmHtYS
Jx/eBqsi7Hjc/2EcHXG6X76+BucZ9ZCySei66ATf1LsOgNFq1pfXE+9PlojLqlFo8BVKPyBl
OjnVkpcEmWnVydFS9pwCYYGXgKmpMF2kLFm24AekChwrdj6AG8Zzq9iMp4PrsRTF4aPnYC3R
/SLxbMuHm+4QGzQqGD4vzkxV7sC3OTY66WT7I21dartT171DbkiKSmBt1y6CuQSG4rP4kTmV
4Nwib+7b4ZRdURW15SjuW0QlSrUA9mbeXOaS4jbh6NKb4QTaFpz7EpzDptmsA94sCGOyQj+c
+eyR+dQbkF8VjPAqxCDKOnD1FWr9Z2ZnaOlnHlfkEaBxpsxOKdbbVhCEKUUZJtyiA0EYSKNu
Hx5YHDD/l13k8ZBkA7VhIg6yGxQ94Gw46MA/+8PPMM6dBUY9qHm6Ln/8Cr/BaDD4Wgel3W4e
1bmmQGkockOVFJD1Y1k5xm5E3wU9X0SoGi8JY9QGsU+8XnwZ7pYTSs8ih5x7R/dLnW+YFZyc
/M9etQusmM3Dx00sa42Vt1u5ifpWkk4iN4ATpONWiRHgeWLF9v36Mi9bFqxG3dsO9MLA9WZZ
bPHW+iZLLQxvv58C/H6LPVNPwv9QOC80GbUymY0CVsyshCIXmtAToERhTNlFHGcR1bBLSf2U
h8ErL4jxKyK1l6hVnQpVFBzBStiSPI2teRT62DuClcK3WpTGj5Z/dAftKZYVMVdpamah7U9v
LlB2rKTZbuGFOuS/ue5Hn267p5f9XRqMt2eD8cWKWUXVHE0wi01hlzLb7Y3Qcvs85eJdLtj3
zH5IsjklR56LgZy3gyM8qWAvgv5mfDbaDpUfm2YbMyX8YJ5Ue0RZT69752M42gtwux3P+orR
63MAzLgQQMkB4PTrqCeK52X5ldXZngo+4mG3Al3tcrKWXqhAFK9SwVlRAuzpSQWK1u8WKjh7
iwTjQgWy0LFecCdB0x0NegW1KkKtLbPAlChehanzUb/Ybu2maLdiBaL46yqQh6dwPvh0PuwP
wXq0PL80IVTbBpa7vP79cDHIHZnHAPTJDsggwbLbLJZ+VbGHx7lk+6H90KEEH9BJ50kMcofK
k0h17C68uUXhBm/zkgcgPvNkCxES0KdGU3dQQ9iVLE8O1S7ytAQ91wGRKuIB2rraarWaCGMv
bJ8Vxg2cOMHkm3rNDbS5leC3/OzufHgkF1B0W7EdXWW647rTOr/lOT6bBHjPNNEGZKOt6KYG
QaHejdBmyuvQZh4Kbf8OMYLimGXGysZRZ8Mu8E9JOkm9zVbK5pZHbcAEApNbvwRFdFilmVoR
5dyb3Q+RHtg8She794fhIw+yf5I8mFfHKe+ZmGXfYxZSHOCKwJx3JlQgV0KxXn4TL5Xm1AUl
yG1Wzv4BmP356i7MAPtQohYDdw4pv4KtvXjXwRIkDVPLjywyA2gZTU0tNwZSbwdwIMOLon+g
Y5CekQWMA4do5JxkX360hd9um6J4HS4HH69haqX2facknOSmJciMpvxavrboWpgo6CX1KUZ5
bB4NpVtvzmIYXMMIB6PktE25MFmxEcg9h8qYstm0MB9F+ITxQMAcXrYwzfFlmDexlSwCG0Yf
uTA8FpZFKxzrWn6KLG3FS8WyWtMi+CqHMZdmR0OQKQ8SqzjP6xv1BpgfP2LyXww1YSjG/1Zs
PXpxmlk+ZlxOnugD5jUl6fRWXIyZi8mbI/3Hc12PrG43Ou5ExeXlnZCotBW53Wy3dVnDsKi0
S8IiOrYTYo8zY+lE/J7wYTgOWHwavLtxOBchYyLY/w2H7+ax/Kxjkv3kpfdgx8FsQvnrSUGb
ESpcQpzQ7kAiQyyDo6mtpgmZOPBbJ8rf+dkh4m/UMxfS7dPM81PMtclQfS9J0UDn4dTzvXQB
szjMImqEMGgA3JIDw8qDSzKXC9E2dogugd0f5c7YDNiQJ8fYysfYK8twn6GkKbbEJLICDxkX
w0WwIjwRP5NFEv8xsfwna5FM8pEexLYYJTXwxwSlmqA+fX9CNhlm6QnGIwhY2vDcwJqz5ESm
DjxIHxpY8cM8mZ2gwYgKcdyWhG5KlpJFKyaCuTd5Ip90wtkJvwhhGCX5Tz+0HGzZOabSDycq
DUmxh1hdwBaJp05j7uF4d2KHWZCemPmsmNPAwe+Ej35PWByLMTGbrEbE+VTpSZouZOxKsMcQ
bNOFsVxXFAOzl81S64uPM+skEEEmfiJdP5wc2yy6d5NjMWV6HGeB9EfGMna8CO00lB6jY08z
mxKZqM2HalIyRfdsaZSpK8c+TclKDjHW4d+STRrJIolmSnkxQ2518plZpy3bTbvVdHVD0xxD
052p5bgYELS2Yzct2+5MvQRHvpKA1drHjcc5/f5Tei3Cql5FkTVDk5RWZymJpGgwRUHs+5MN
to/3s4257PXtZDDsfuqfHEcPMyHtYYXMkAW90T5+Lb/HSwH3T2eXWApZNovdRnKfpU74FBRD
AHeIjjiA8IvlDEhxOoMFKaWtmJYwuLeS+3xsSJd5FGwahtaEWhg7LMazOqhNVdF1MXFYSOUH
1HtL+9FEDFqiGXVQNEVuqXvR+Ajd+5OCSm/0+deCqDxWWTTxrsktTCsEEOXEFHgm7Dk9iLlM
4ahzyfOO2jJH6Sx/FNga8iStA2pLVRT14liTVUM1LzY6q1rLUJWLZedDzzNQb7rWvkDfw6hk
1VER7SaeheJM4WcU0Otg6jpiTROMrJqsK1Qqz1Awf74Ae25JWxfuUQbsQQtc5r3gkok8s/St
Bca/kswawPWeMTUByDs3puMdHBPlPR2dANRAkU14OC3UBtTRT4QxCQA+EbgEsOXWEgDUPQAA
0QNnIAcwtwHkHEDH7nUfwOOcGwQHsFWXj+VygJbLlhy00QSH5QA4GqRshANM8/bnAHY+MuQA
OBTdBwDQoGYUAIojxJb4CdOnOQA19z4REIBsIgdoGaZuOTmA7WrM5ABGS1cPAPBZfgGwIcIK
DYR9lgH0aEqIPMNzIb33Euq7MNuiicn7MMBMKcHLDH4fwRSFxOgZ8Md22Wr6co623mg0rh8K
kWb3/O9v/hSRKIG+vh30+hUOAHuQ3vApRUpjy2YT0UHXjmDKSK80EGhAV4QtuoBNFVu5dzZ+
Ok+31KZzZgXUjlYq2hj/WXDWP/38aRksKB3D9sUbe5GyILFckZajjTiZmHJH8RpVeXo/6QYu
YHTDkQoTgmFml2A3wMWhG1bMgJ4I8LxxRtrfh0RGLnRRx/BLD/hyVc3nzPGww6FJ1JBA4/z5
6C8/Xbp3s/Ef9zuFI91kYub9pvcZde5jxGA4INgtNYoZTZB41C/eeyymJwTioSGSefPIZ3N6
5E3m09il/S8qQ1Em5d7EA1NZLrNRmhJ1h0Vicvs1BGIQgW6IzYh5xD/HPFtZHLPnrcfYGxSY
iQAfTsCTFZMG0JnEuIIGyWQXNLyolY48joqQtzi6Sbg29vF5dTMZ3PxzjINLzL+CeOLFfyTi
JIrZOgVaXt4lJ35lfje1cLxbx8wsdk6WTyj48GZ1tku7XJzxjQ8m7pYs7ha7RK2jJiPSYWAv
AKE87MbCmJ7yRIsYc5QUavYRYB/ahBtk9tzCXGcQ2A36noUwDP3AindxsSuBYffr5PK6d3HW
H03Gn097l93xuI/KAPNQ6QkWvz3vrH1KP1icwC/6/xqvCEwcyJcR8OrPu+PzyXjw7/4mPuYl
L9XQv7q9GfTzSnZG4OUUvfPu4GrJFc/FS5miUmVMldaxzAX5pNR0wV1ms/G8wA07oGNtmCIU
iLGrBxqQS0kaY9Rfgrk4bud9HebFyjIR3yWW9nx2y33nBkXe2x0NRFjJvJR1Xov3lk9B0Jc+
3yGJMPn5/sT19z0Wh3mG2Rfee0owj/wOMT8Usf9ivrtSF1vYcsS8P4QPxP6rDy9W0ZVO8e+n
VSHge/j3U6tAePr+GVWsJTjDv58ihZDgDL//gip6P6uKjY8TZpQzZMHPqsJbTgVgYsJ85z2q
+KvcOmY2jsW8R4a/LEfKNbTxWXNacvEAdgkw/Kq+DzbMvWeamiXgpxjj+TvynWML2PfRyQa3
hHVMX4Jv6J6ednewP3YHl/2zV/NdCk6nZdiV+N5UxCv4rqaTn2zflJhKlKhKOJb8jVJWiUaZ
UvdYUcvdsxSGMtp3gNnPjaq8CzeVYBBoTQon/4ODKYFZTaj9MBW5yfWTA3G53sJNrp8fhynn
prJQ5dxUgdlmRMyTSKfwq4Iyaa+H2WbkzTAHuNEqqPgAN1Vg9nOjKu+im0owB7jRKjT4AW6q
wOznRqviDPu5qQRzgJsqznCAm/fwKfV9fKoizAFu3sOnKsLs5+ZdfKoizAFu3sOnKsLs5+Zd
fKoizAFu3sOnKsKsExw+AyR5Qb5JqpozrBOcH4TZy00VZzjATTWYfdxUcob93FSE2ctNFWc4
wE01mH3cVHKG/dxUhNnLTTVn2MvNG32Kj+3y4fS2M7xQf1XCvTWuDb5ijS8R7qtxw6ir1fgi
4d4a14ZbscaXCPfVuGGc1Wp8kXBvjeobZTxI+DNH8t/h9zALnOMny0vF7P2rOXh51u7piRb/
gWt5Pm1trDi8W2HkmyETmi/xglmnAr3rBV5yT08n1jgHJw9f4MbPn3XMvWROS9HeKBRA/6zf
Pbu8QEsKHL8o1FsPB+qlJyB8jjDAVs6napnzzlZX/cnMVDyLAVqNBN/zJvrr2TloG9WkSmnB
2Y/CTPfPpL8aZtnir4N5k4KLKv4Uhk6dFvuB2lR4RLGthCUQWUnCnF/eUO8ugVgb3wtjmvh+
9Pi7Avh6UEMrPAYWZfPdqdC/7N3QM3+ZVtnW+Npt2d5aNZg/Sd9cbH4fsfQHVpgralPW9WZr
a3G5qIaQRV1i3cRy6/nmM3tVNo07SBO7A2f5dlNUbFtrGLIJw/M/16u+1jSarBg7QiCAxBch
v3onkdp0NL3NTFVv7wil63KrbaimKZvbUtE6+jvoWb43jcWKKYf5Fj20DiOoJQ8ebfY6Ett1
U1p3kLFGAwzNbDVo41k4C4eD0RhqfvSfE5IRRdxoGoNLFXnOBLnpILRrZT62DF9kOMc4P8/m
HUDZ1yRNRWvS9p4sSA8sdFVkVV+tc5XrAnB3lWtLVlo5FH9vwQ/ioVm0UZo5tQ1foyJeTZAg
MQx7fZhawcNaswqZd146f5MDp0oXEQOJr5Piiz1I5USdo63pNc79pYWBX6xO924vT9cc6xen
xKg65AedDmtanet9g9Z5ibYOyqctCGw6PX+vxOZrKUB8c08erRYv1s6t5In5/hF6qDX3yGTl
52adL1f06bdm1wHdJIp4tyk/6xtqbXJFjSN0FAT9okJndTL3Um/G1y51lmvnSHF2OI882obA
d2vELBU7g/+BNzdI1guGf9msTDVEZZmPpR4ZjFOS5XRBwa4DXzI/YPHWjmwMCFqrdFtJpqlb
m0rsMFpMcuf+TX5WNNpVolgtbf+2EkyUdWRoxGL+SojAZtCnwJLQZnoYDT+DEyOXcZ2noU+0
xI4HngTCwF+slzKphkx+c765Amx8aAmY2kS938HVcADLnRYdzka+IMzGbDdltLNHrG+ihHCp
cWm9W0xFJ2uWwmxeolUtKBzi+oviDmhNMXSTXlTwmM4jFyVfPzneKNTUzd0I+eN7ifJIr7YM
mbasrN1Xa2HT3IHLl5uURoz1qn1Jq69f9rE2bA2vUfRbGk7CaD0QZe60k3W1oi/vZVdkutxs
bZLRYrf18r9CaYV7D/oVOgythY/Zlv5Wd5JsKjbBrEl1XVPpvREzcoUwlpxsPl9wu6NtXnNG
b1RZl262zNd5wTTDzjGdcH1N+PI52mBlkCuYxn5P0FuajOxc9W87cLPqVfkLJ0I79EEEls31
d4ait1B2O8qoSZe7d2chukvA9wIG2bqs6GBFbjHNEhGHacdbSQ9u0JaSO7rb4UX4eybWeUsD
A75Yim+lZF2OQVuU6Y0NhLwhkmFw5+A4YleyvfVOBs6Dwhf50hZBsGyKHCvylmnoK567Di2f
nFyPB7Vh6GRoimd8q97a3lptWdNLiq/D9C6Fif1/u4RCa8gwGfdG0KdlmyT0hlmbwuIOVNOd
zVCpZFLFGlVZVUqI+funpDPsQqQvnsPCDYq2Ia8oFH6E7vBSuGOCZs115mY+2oZl/5F5ZDR8
v1toOes2RS9qGs0lDnViMeY0+L275BKlQxdcFqytOvmxDGPjaF0Kkzx1WUq0Le35p6b0CJxe
igFxmFFKtSbSZNPcsof7kIwm9pwZQ89Ad3pKhBMR8D9om0DASD6MGPQWIQZ/i2zvJAjtOPkb
lzJfPW2h5W3UY7RkbfVKinzLngqfRv2E9hOI4Zss87T644pKM5rrtiGzvwmxrz0VzH3DC6iV
Gjq8hRC01hm+kR/JsuS6d2vFUOBEPVt25MHoaiR3Za0jyx1q5l4H0I9WGv02ZjPqmJK7NbGp
GsYe4mUPVOv2J1fXt5OP15+vzo7+kXcnfDHjeLTag4opEPe9AhShkOCW48Bw2Lu++jj4xJdk
0guZ0NLr9F6bD2nui+uFy6SQbe9NIsv+f9qetbltHMnv8ytwn9besWTiTerOU+c4yYwr8eMi
Z5LdqZSKkihbZ71OlBInv/66GyQBUZQsz86mUolEoRtgA+g3Gpg/NcSMTcxed/PY9kMQwmia
7o15hs4d4egQlG8N7E/gGdFxL/jZndgkAFDBSe6xP8ZzVhwAx0Pfg5Et1o4nJOj7InoRsqE7
GozCcwuZPnhkTXVu+s1IzcEjbDjA7CrGbCO1B4/Ur10PnYjEEHQFGQEH6rA/8CR3hwtUA4ln
4ylQ4PdY+Csy2LbCAXIGxeQGDu5xWDIiG3DwEIcROt7CwT0O3oQD2bLHYRLQW5twAGdGSxFH
5GZ+IIim8F9ACgtaSJ0UBD4Bxj74zi5fv2HIax9LhNwjjPiIZp6PbIBQOz3lcITKI5QjE2Ay
L8UUB0Ozbmg2HJrdQaqdCAfB0Gw4tMRG25Mvq4njXDZNfhwuoJiDSt2EoxhC2bFx28vIESrF
6Xjqks2xPpYiHu4xCrLxn8VoHUYbNWHsXr3yCJXkooZQ0BqHLaI6HP40vKbc2CdxA9EJR7Cc
3L4fuZoJtO+HhXoPojtYrIkgXX0nrtjjAsYR8JAorJEBSErm0YhGRiGazKPJtockIhWb+uvJ
gJVEUdZAIhGSSMBMiPpKkM0kyvoDP57hRlkWwfn2fgnR+H1WVKobwH7z4ELsHcUmVWI/in4D
VQTw5zou5RZOOlJIlaaFwzeoIpLt8agaVcrXUe51bDAE2fA6qkYNv1a4Xysb9VSE3D8KEVLF
L1/4KJEqRuHxzk3agDEm6xj1C2mj4u1NpXfQJna06QdD0Hz7pfRO2ghPG7FBG204armlpThC
u4gO7Q7ns8y3SrY3rd5JQeUpaHdR0FgheQ2jeSEFQWxurVCzg4IDR8Hw1dGE3Qe+SUHpKSg3
KBjzvaOo0Sb2tOnvok1sdFyntn0hbZA09VHZZtpwx0h4yEiSBtrYnbRRnjYqpA3STKjdaGq0
GXjajHbQRkag7NRpE7+MNhK+ba3meAdtHFfiAVeS6LCt8+h4J220p43eoI1QZF3vQrNJG+65
Et/FlSTMmqlPWvJC2iDLrc9YsoM2jivxgCtJqclluxN8kzbG08Zs0EbJ7dWb7KSN5zd8F7+R
KuZbHDt9IW10w05Pd9DG8RsevpTW+8E3aWM9bewGbUyDApXupI3nN3wXv5HGJlF9Jfa9/iN0
2m+gTRxqwtI2iKP+Lv1nFPuXg4/BUGJjrWywCcGCv/54dV4UJqmao2BXoRfksnLnvB/PHtkf
76/fnX9hR5cf/idnmv2dR4z7mosy4Zo/B/5qD7hURjwDfuHBAfrvG+A6MvwZ8Nd7wI0Qzw2+
W4L/PQkAYdz1LU6q89f7NF32fTQ3zVkfbfHffz0vSo2VOFTUIF42cHgYdN5gGsQww9ov+dl4
/jMshJP5t1n1mcIEZ7NA48AOtvSDjQ4K/wymFSznE7aY5/k4CAQpNLHhLcvmmw5GYL3kYMTS
3TCor52ypj5+Z4N0QVXLyTc4SjF48RX6jjy0jDQObpH3nA+foG9vu3RE92u2bDPe4KpWoBnh
mDxctwwTEYxuy7ZhreCUOKhtugX/WPZhPpxPRnP263g+xelh/3VffPpvqsbUHq9+8f1oYMSw
NIZfMUY1LF6ui9EMdo4BJ4xz4xu+pnCVrwMUnLdX6OdQG/5Pcuei0xSWVN1dqjCAq4vmuH0p
fNvDSB/Vay+rARi1eRpaRbHEXVBWYKZiPlRDvb8ejWBs3ksVlDVPNqwmFSXkBX4OR1AvnITo
Bg4uElS6NkJW3W/jFZUXhYEHP/iyoRV0HMfoBfrkaiB0YFmuJ0MKf5bLgFEBbqpN4IpvoT8c
vntKJEBCwPH7224HS3g/gskPADkb4v890wal0rflKrFlW/z9sHD5jmg5+tKQjy5mC2Als1s3
02gG+BYyTmJqwQqWfDvB0nOwom4xBYEg3IY/YZevc3Lj9jELJB1g5DboS0vSewpM/CBMMpIN
mIzBkEuJSRyEacSbMMWxDTChE2g4TZnwyyNJdJJstDigL9vw/jriXAeY1EGYVCMmQVHhEpM+
CBP034BJJnHw/uZfwGSk0bWVBGYlsR5bL1iplbRofW5sOgwC9BbTepy4MUpcixFjLg86XGG9
z4JOtFKNzuvSvawOcNJrZUy0F4s+wDuvlbWF7N2BxbzALa+BDUi9D5t9gT9e49zZ52O6wgOA
EEWtebDoYfnLbNbDWBGI+2WP+FATMxLah+I5FnsTcVzjRlorjv7su4tbltGNKOMcmXATOmJm
JT5x4qrKb+HTsCwcvj688/OIsBZfHIF6tYXJyjgiTB32W4Ulr2JNGPEKh+x4LfaJnwI8wG6A
ch9f3z5LJIHV8rSts2ytkxhDd4Ci9R6PM/9ZPIaLSB8QyfcAsJRgCX+4vdgAwNqhQ/bx+vIz
yzHhjqoUzXIKeE4pBt72KEDzjrZRrIeLfUAqtnYbCFbfPiBtUUQ0AV2/7X5Vbaz3O3gcPIB0
zib7EJlEHLA5lPIQ1uq6mk0BqvdjTHvC5L3xEvQwVJlOUX+nzkdBGoc2oFXUrWmKT6GbXxbR
Yopmg02G6VEfskmW5plHkCRbXnJCcI5s26UQXnbPqbozkOCefZsvH9Mlcms/CssxbtKgilPw
v9TyKVUkf0iBpQBdPtxc0dUPFS8LrkLZdHlrC4qXLRTHi/ddFpX38BQJiKAy+rYKaAKLfrZI
i4JWoKMs0+kob7erubLaxgoG/HaZZVWbYVGbB3d6rN75tnGCvKaey/nvy+K0JrLIjaq7Onbe
0YG5XfDAYEYRMJhhgEIYNI7uHqjmHBC/SgFCNsDcRS/ZrKrA1aaml0usYQjTs5zDa1BePAB8
G08mBQRQiupzBVaANYqszOt01c2mY9a9eMLUXmc3+Eaa47RgOnSPTgytYAsBN+y0Wi28GmZJ
lfkpf+oPKjH2pcNmVIVhmffyFYir/EywGR7ZCJ5EpB/3yAr7mk7OgBDQaX+eZ2ccVhqo9kDp
6lcJrdcr+HKmWVkOtgeEQzzzGbyxb1o+eJhPhvC/zwGyJqb8lcHy+2I1n94vezTmI5EcuwJR
95RnB4+oehjWiVo9dJgVqpBhbJKNVh4bKFW8iSzsAvHg5BdPesXrUDGpCt6C1BYHwrt3r8EL
hXPXAN/Urauy7a1Va6VGV+u+7vFxr0TmJrQ2BGX0M0MIRr49BFDnmsFfMAQTy+ZZ2AW6PYyY
65dQguy62igSyRu3yOGjiDlGwivCIVvr9UEUzVAijVw+3XKwJn7X8T2xpStN6Pd0LCRu1yZE
N7OsfO72a4rpSliv7z88OOz2ZmrsIML2mwBfFL78cJ6VF+Gtlut8RZXqv+P1V57jJRFpO++y
784R2Z/A/kOls8HNYhOeYKYcyjJEgqcL8A1gFNNFrz9e5WcyIl5NqtEZt2UWpPvu2UEihYKl
86O/HtY9SMDayVNZjWgwBiGUL2bZ/bxxTEajwb7ZfDzEGr9Nra3E7PURJpFRNO6ocCxRTqNt
C3vs28aSEiuzxUM5SHY0HeZON2FSVE1jrmKc+GoQaf59CmIDLyrcHgSseYui8dw3gmlBUZPD
Cv3bk46SvzWCwX4D5S4FBjoeGEUstFNkwrqUOx2bn9likq4wj8spDhefY7I26Uu3+8ZjS3gM
c/lwn476oHP/es4GeM2Yq1zqjmu0g8ZkxheN4f1BpoHgoe/tzazobLmEobREZc3EglMC2HgB
Yq4slloKyZLyMmkHAOiY+xLWdLygmo4Kb81cpb8DYVLv4Wuxy9urS3aL8hdlE/s6TnHZ95YZ
Oln9SwDTFgneyLVYA92oPXsFPBJz5HN2WpjQp++vP3f/0b27AnUMP99++vDqGj8TnPs38jhB
bbKVrzhE+QcAvq2UsSRSCbp5utkSNmaHAWB0yg2YhlVmu2KUEHhCTkDQ95ZOk93MEk8kbHBY
O4VbguplIiu5PL3BNIRRzI7wjOYZUyeUTNvrp+shfHX1+Y9dFV7q97xCaRKOynDhn0CU3KMU
HqU8HKXlCWWJzfOHcT/t0KpKgwtM79wPbJKCOrDwYNIq1KrTJbbrLQalI8fldxaZOFsOFA8P
WqGt4FGdv2jlq++TzKUow3Y+wWI7aL3fXnRvb49OQLs99pMEGiXuCQ9PSt16cerO/bwigTqa
FNfwgL4PzIccZQ0DriwZ0HdR8gBXV8IDxlHB6t0PmGgFH5CJ9sFc6NE9KCfMGFBws8Fpv3QY
ImgCRl4dlK5NmVIM54TFWDc7P/0GxrYm50TEfvuBfJm1Wr+UQR68MJCTO2Dv6AcP48mw7MhD
ak7elopQWE18NEFLGSi93ZoUBd/6/PcP28TkkTE6CpsVVyveg/m2YtnTYLImW6zISR3RPYZk
IkGHrcnURpPJwmMDWyUhMvWKnzrhl4KJIec6IXV4nbMWFx7ceYAyjEy6TOnJ0Ydjdvvh5hQf
setshWKwdPS3Ahki24K3HuPW9Xm5NAEfj2TMK3yb5Wp5kiQtqllbHSsCCoQnVXjbCNA6oy97
omHlpSS4dYGDcO5BQS1ICkOwDEG5Jsj46GhUC8TQ/b0XN2CGxoakFI14I+mJZasHeIcjxCfl
1W8/OlK0YMUdMy06WmEzLjpSdcorZBFZQvHEnch2E/hiPpu5qzYrZAmnBMNxHCl0TV/fwj/d
U4FNMWSFcuWPwrfdeffq9Unhne5c3Xz84jiBiU7gH0XMgJ+U046oldNpgU3PO64HBiiYSy/f
AvVwBjZ0De784+ddcFWHmJCP3s9CKJ3fuauUJxTO6ALPEagb9OcomkMhVQr5U+rqlPrdEFHc
94BXaXxhy9WgRYpn+aGIIZcbHbDDL5EHA3s6bgLjDWC+N8y6N01gogHMkwE0cKTfWAzoHUtP
WyEcfTNhMDe52HTIAXjr2xjjbWBdo4FeLJrSe9T2kGAxxV/KsxHfhkDsT6/vCvyE6dz9xFDd
B4nhaI5n7NbIvsvDRHkVmkOkiTRmEylKTXTUZi6WHynJ0gna31jxGG3dChg2BLorQuBKsfIP
m3Qr7XHwBEM+41Vse4RhNt8IKGMTQbGcfAAdRtSGLuJBfUrgDvENpcbE3KDhODgCxabrnFwZ
+SIDFXvsGQUXyqJKkvcHYBdHbhy1UuWy5mpBKB3jstyA+lQelAumpfvqAhv4CUAtfDb/RleM
nJUnoBEhKh2AcJoPpO3bkiLdq/yCSfsKHviDeDitczyIV/YEHHpjiiuvFyJOYvRQ1hF/JH6L
b1dFIqfjfICrF8QAXafDuPQbSnKOysm3WMbWjnpNq0XtXi1SiFgRdFJBF2P/yqsQOjVM0LTa
aFgI0p3jPON4KSqsrrMWN56iUvEEeNM0HTz8+AaG2hV8+Cf759vW+/k9GC312RoHl954HIZj
FLrCAQu0QkDBq6BlrNyC6GWLp95A/vlxxwJXgj+JWdkKn6pHL0PtF4NMEly2e3GnZc58td6c
05u5q076sG6+165+BswK74X6QgdcCUtwfLFNT3uzORo06L7Db9N0eT+enTkvpnvkLg6LmveH
kgpPFg4W69Ey+7/ejBycwJWv52z2lj6jsreAHetBXDZuPnwYjOFNseYLXoJ9P8ZL137DwzyB
yL0skzrqTFtpjXZXgaVSfVDzuR0DhTN2k+fTdOYBjBZlt63FZDWaQuevfwPNp7JtUf+/eVuu
vIdssgg61KBrAUMC1vmYtUbTQQssW5Amyw6Ynz9+AI1mVaoTtgahYspaFFfpbA3vgH6WZcch
cDdv+OZoiJbNb92lJBSjKZoPs3x8P2vBKEnuhXtBS4s24K/nF3fFOnBX2l3f3DGv3nCtDOah
denMMru7YKm79uR94CfBZpYSjEHkZUCfUv3kbc/RdaItDPURRWK2PF2LDmdHoNnu9bmauLrg
yvtcAZkx6pA4DffCyThfy3MQHsBGEuf9OYDEAyBb/MI+C13mGf1ekCFqi6BVgikkPbxHo7ee
4QHkbFgc251leNydu6O7GLDKyUpFhhyQGjDgEjnoSsV01Fs+LRcD8v79HD1ldPg9qZ/49RqT
VQk6ow9C7jH3YN7xcH1kT7GuwGAPfhPb5HmqSr9urI3RvV15s6jXLY8UNoxppW427OWNTRON
52GeDfP5cYNiGybQ76UL6MjVGWueRUgSle0mSSxAmgbjHs7QW5TPJ8hMGgYfSzo75H2M2eKh
uV2C6ulk3K85Deez03levC1skVOhPF8GMxW5FZXI8DoFOSexIkZh4h4tBx3Q/AIwE6NCQLc0
94qrlq9Scsyy3IWrjwS0AqsaVsAJi45bvxyhCICJ0JE4QWuXIw4rw8HECQoJZDXuoLYrMdEC
beRzW0cJvPpy5a5xz7wuF4NQBN7weI5ZU8W9Kwy+sMFkjErW16jt0/a8xxwgYemjtuIgC1U3
0KjglRNbNkYLGQVJoyVT2rWFv5sIgpiw/kgrsi2Q5nj0VXVkwj4CTz0CbiwS9Gsmx74DSaLg
/H23yrFEV3gnaBAjefAmXZC4oL2gzzR3ikzbt4oV6ghlmHQ9I3a7cUVex93GV4HwSGIVgk9U
QB2XCZq8GIaqrohirsiT1UI9ejAsnLEfjMq1YZUM8tF0YJ9HkUcgpKScKXdqHQYFEgKX3jEY
rSu8UQltNXZ70738TDr9Egk8oFuJHmCymDs53KMGvbvLqzcfuqjloGqFisRpthqcLgfd9vC0
G0WjPvmpOnQJKwP97jTvj2enoByR4UOqSL4ePLARokb3DsXxgVzVeNGLCjJlOcD77ex+QWZV
FAqyn24phM+wXlyH8m839XywkwQqYIRb8v24oWmIm0KxNNewbEqEKP5wixa2/eX0zRO5KX7N
Zhk6/d88LSZz0DOwNg+WPXjGvOeheV8wa9mWFvR96AQ7TodTGLqS+4cu5bZ8l5hzbfE44z4p
qfUeMelQoPw+oDgGFmfpLWdDZNcowES6g1lLzEEVaMAegJVuxM0mox6sqnT5/WfEawD70OyS
BYAe9CH5gkGDQn4/6xFFEb8hUbON/V25Z3OsYYP3RrObd0WkT4EVISkUUXa6WiLYdyyRFBYt
WbvfaQuzoyJnir4d/5Q/TDvRU2rxiAHlf/RlJnTGFTak+5CPq96UUmHRkj/RG2EybSWtMnbv
IjGc71kkDoX9N1RQ4T9FnJFvEf/ayH+OdPD5X/krm5+P+ixSeIggMlu/BkMy4fP4LxoSb35u
OZN9pvp/3bsf9vcnN8sW5ApXtllj3prlxaj3vxgnpz1bzbMcwjybJrWWIhKyQ0Hi/DtebvwI
2saRjNQxFsFaw8YbsjfXN91/dDFxyGlEKZb8cCm17XKQsJQ5mnIXb1ypPGiB5Z6QdU7Hs94w
m6zSHt5hCSobFzqiUEwALJQ8DBgUcF0HptDyAcBCS7BOasBaHzZssDdNXACHZButlusZqnAG
2AVPDiZcOQQwWSzm9O/hA3IPF3AIkkONnkOVe3rDCN4Q2PloCWrW1+wJtJgl6MHSvmRtcNlO
gMVgWsEBRI61EgWRd+3HjT1CPdi2lorjGii4cWsg2JFNnpHdwmzlQyEqjeHXv5aaJe4kAh1G
FAciqlMY1aBlUW5qjkHCVbo6OqbO2mAFFLaDu77U7e5iBUnVjhOXO14OGbuuHY+mVkZg2ljZ
SoSv9vRU3ox5lB+j/w7pNlw7jyxenlpkg3pkVqmAJ/FK4r0AjcHKT1QfpSIBaMxxsl9d1Fab
+rxJ2+YYnk02lsAaC47O+3gbJmj0R7dve5dgMp908a7J2/OLd2/unDCWSRuDtwhNxdlgJz5m
vfmiEyJzIRR4j/xhPFqx+QLD5y1u/hNv4a5uXr5fptMSJ7AlKV6OE5jUDpxGgMQXwvLCSMGi
w3fzFaZA6ARsT5CEYLU+nV5hjhQsRgB5C1YgfGY/vc7K7G9cYWVopzo7hpmptJuEMm28ahp9
a/VOrAWDgSe7O6ngpUZD9PL67U3H5VZVLx11YIv/f2vX2ts2jkU/x79CaAeLdhvZIilRZAB3
X9Od6Ydp99EFFhgsBFkPx4gfih/ppsX897nnUrIUJ67loPkQW/IhRYmX594rXl66dFF1oM0C
uRK31+mSHKb9zMawrcutP3R/H8j026ZodQ5bzAwDf51pPwiEkv4Uk/lpqL2Xoi2tFeLGXxTZ
9Ypa+NYbwTsbkd81ci7d6HpH4xRtbPZ75XDMF02wyObBvsSdZsUWMfbtfbkG/kimCakYD0Tm
zhCL/d+taghkW5ooMeAcqXPMUWZun8z6pxgheN6fvCTh9xG7eUHsEqZI/Ji7KSYGaiMxy0fA
yu3Xm2RIS5qkOTyBKIVp514gOrjlDEAE79QqJaGisAOykC4C3dwtks7rkASmKxXg7JN6j48D
i7XcnUqbp8j2vCV0WMYtXBg4nI+avNlNULfmt3vtHcahsA4O7ZJgxz8O5UMiTK7bpC02Et+o
Og0OqjZuSS7B4cEmJIeEXyxWSxC5gLkkRVs5sVTdJzyKd1VyC+sZDy+WHRRPFhGqnO821wlG
2O2u2OFBCzuBCdatk7xeeaQFMjtsQMTUTWD3VnDtIuhRcaiAnbQdbbQwT2PlY6iNdSNrrpf3
WHiSLvkTQ61iBYueBpCEgmGQsrwDMlbW9ZUVC0GOTpV60mJCjjcgDA86PKSEDCiIbIlL7pEG
c6oOma8S7O2MYRChJ/NUdFA26N/xJhAGsUKu0ul6RX3ZVI07tnmLlLF1zxHxbwA5PEHR0LIF
Km32VSI1SVK/1kmUfIN0HhhjQdDijRSuYs74mJD99O7Dp3f/cvAInWR0i7YSsTNPcam8skad
waVGBBq8/jwuNcINse/OpUZotl87irHm0sgYsCju8iiXGkFaSTzJpYb6OpI9uJRGbhT251K8
ZrWnuBRrLUTcn0uNjHgytCeXGiWbYd6HSwneMPtJLjVK8dvwvkNKaWGPMdkjLjWKlIA8xaUI
Fkayq35ciiAAdYzND7nUhPvOO8mlJoQz0ItLCdqXS03oJpG+yaXE+I16P8qlhLG1WjjFpZEy
Qp7kUhoE8VPD4EjHR5E2uheXIjFj0IdLyQg38gwuJdGrZa8Pl2ppEbf0FJeqK8GrIPuTqSUj
OXw2mVrFrxG/P5naSCC6vONUPjBM+S6PkqmlBuN5PkGm9FMzyL5NpiSSOgx6kynWTAThCTK1
iHmU/cnUkhg1yrsHmVqBAM3eZGoFUZjtR6ZI3mKP8/ThmLJCy6NU9ohMLVmF9qRhSqgzDFOI
dWB6kqlFIFXcj0ytxOKFXmRqpW2szVNkSlBbG/7HyZSM14bHj5IpVj4p24dMLcKwzCkyJZQR
/Q1Tq2KtZR8ytZFpVPm3yRSpd2pgLzIlvLVxXzK1sbEwzztkOivdO4YrIe05dinGqn62XWpt
EEKdfncqJbPSoEua26rbByols9Lz+C75Q9RZGZo8XK50LPTTPj79pGUfH59EOwxlfyq1Nqo9
pmNUGmN/FhnWF9/cL7Pr9Wo5+1Ik62xHslQV+YwePCpnFrGhbguSvrdPtTrvthpAHbY+FpMI
9eY6ma1BTgX4ppi04FjV9I8WuLUpaEiSVbtksZtjBEQCtyDaMmQftmUA5quAAzG0eCjS/z1e
KE5mggYVd0lepG5deZEs0uU9T5viXlXnCkIZ3VhfKMO00sANhplQZYsmi67xM0jq03kyuU7c
EoJkVjFzWybOTpEoih5cAAvbi6Scp1NokZwZUeQt3jYM9gRaQG5C2QGbunLMgS8L6oBVtp1D
O4V4lHHRigNZmbXCeQBMMTUog6LFkV3hyCThPUm2q2S3KdboUcWPI+tAbdSxb5sqZYrwrVCl
LZBovtbqPFBpWC5zzLcmjjswdYUHp2ynSGNmk2zdlZt97THkygbtE0YSRtOTf2PeMUQFdYdU
xbpMNp8T3rYEdQOcRS02bnyvG1Dw/gYhF5HpwIyMmrbSEDDBQwI26DYVtHKqyCxUHQJ+/+ET
lWGswkNWneZannw6PP739eozT8MQ6bBFgnDOHPHPiGJx8TxX+0Lk3sDRk13o5H4f4xhcyZGI
u3ALw04wvEWDXUGu+UiYDljHWI3svQyuPCukDKOiRODVji027uDXX4f099ullyL+Givukw21
HzMqe3NKuinqVrhCw+/NDhrRvocdkRfTaQUM7boVRoR5EQWZ9+oPm4n/dpMg/Mx/OyOWwQv6
m+L+pXn99c3wTdOkR7aHKDu2R4xNPXix37G2yJE16qqDNiw1aEuZm5hMJ/Md20JGd3i8LWoE
y79tjJaOEtGYQqo4N0H0/RqjVQxb6lCwGk06gurstCXkmGbXSWWUR2WhSVS2y7lrwYNrHzJa
Wh4Qmta82IwsBLqz1GRhnMVO8BoewNxaMYTaeFz9N3WiztIDnahjXqvcHtOIp14Yn/N3WHh/
HIci5MhKDn/hePR6my80kucO95bN1d7ewtGmrQM72tSbbgXeP97/eOUJ4/2NDPqrzsg90+hC
vVphUerP6TrngH0XtP3Pd7/8B6k0sB8R9rfwXs3CMPj7f703nAzmEqvz9OtLt/sNFgYOpU/G
UzgKxIh8mbYT45iThj0ynvgnW/s8/ETAo2wHTVq9gsX/tnZh3KIBMGgE9aPjVqXF5CbWb8qx
JDVpzUS3aHsF7Qa1MukUMXXNN9vr2vUUAV9ftfrBuPWJ51RshKhtprripPXVknJZe7img+cV
mXwJctLWqwU8tRv26KC520dpJIcZ1VL0sSw51cB+LfTg3TytMNsK0xjJmILB4LZY7PzZYtrs
2OWX3m22+ixR6sa/p5G38u8qXyg/QPamn84oIM4tIM8toM4tEJ5bIDq3gHYFBjd3i/GrwQUX
dLrYJ48q0eHgwnfmok8QOiDb16v3v7t8s1kUFf6nFf1SB6L+4D7pRJ03aLTazBZkOY34uu6/
37D/jKzZYTb9QvCFJ62mz82i8gR91pG5vJb0kniVjsf0EdBP7giz6OvLWd6c5VyrLgXFMgNq
5bvcAPR9v0RnpsmsKTaTzjm/XnjBep7Or7cZr4Afs8EM4UNrsASFI1bHj0XtckFEnPIPl7Ny
fDdbU4UnConnFJLPKaSeUyh8TqHoOYX0sUIbTqLgbba5q2O2qZAKgNPckriQIsSmW8vdfD54
PRikVUUmOoQY+9+MEWM7WqcLEoyW49zCKRKuuqvTig7r7yT161sy8D6neHVRb5N1QXq2yqGT
oXDh93GCp8ZZH2MjmwsSv+GshJrBdmgXFYn29mZI179ZbKbj1ZJO8XV9ujDWb0Eb7qq2McvF
LGlkccxnBxerVbVpvnO8K90KHtBY4gIr2ArNGbpkvp7kQ17P5jyJseH7oVGcD+eracJrv8fF
ej24mE0JBS9myicHF2T3IAxlvN3eU028Bau7gzFnnbh0+R8e4Dpn76bpeIndpKim9efBhUvN
OuaUuhjBxXzE//0MN7irfN4HlxzrIAriwcVfP378lLz/5S8/vRuPqpvpiMuNQAo+gnacTeZv
JoHPZRQp42mW+eHQjmrNn9sg01msS+xil0cqzCdpXqbxRNk802mWje4QO7j74h81Hp5+fuh5
craGTS4ses4kZS9++Eo8+Ouf//fbC893IufROfft1z/S6cHvUi3C7om4AAA=

--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vp-14:20180730110424:i386-randconfig-sb0-07300301:4.18.0-rc6-00133-g7acf9d4:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 296
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-rc6-00133-g7acf9d4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.18.0-rc6 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
# CONFIG_FAIR_GROUP_SCHED is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=7
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_ANCIENT_MCE=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=m
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=m
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_TLS_DEVICE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
CONFIG_IP_MROUTE_COMMON=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=m
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CDG=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cdg"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_BEET is not set
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
# CONFIG_NF_CT_PROTO_SCTP is not set
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
CONFIG_NF_CONNTRACK_H323=m
# CONFIG_NF_CONNTRACK_IRC is not set
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_SET=m
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
# CONFIG_NFT_COUNTER is not set
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=y
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
CONFIG_NFT_REDIR=m
# CONFIG_NFT_NAT is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
CONFIG_NFT_QUOTA=y
CONFIG_NFT_REJECT=m
# CONFIG_NFT_COMPAT is not set
CONFIG_NFT_HASH=m
# CONFIG_NFT_SOCKET is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
CONFIG_NETFILTER_XT_TARGET_LED=m
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_IPVS is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=y
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=y
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
CONFIG_IP_VS_PROTO_UDP=y
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
# CONFIG_IP_VS_LBLC is not set
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=y
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
# CONFIG_NF_NAT_SNMP_BASIC is not set
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_RPFILTER is not set
# CONFIG_IP_NF_MATCH_TTL is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_CHAIN_ROUTE_IPV6 is not set
CONFIG_NFT_CHAIN_NAT_IPV6=m
# CONFIG_NFT_REDIR_IPV6 is not set
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
# CONFIG_IP6_NF_RAW is not set
CONFIG_IP6_NF_NAT=m
# CONFIG_IP6_NF_TARGET_MASQUERADE is not set
CONFIG_IP6_NF_TARGET_NPT=m
CONFIG_NF_TABLES_BRIDGE=y
CONFIG_NF_LOG_BRIDGE=y
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=y
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_DIAG=m
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=m
# CONFIG_IPDDP is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
CONFIG_6LOWPAN_NHC_HOP=m
# CONFIG_6LOWPAN_NHC_IPV6 is not set
CONFIG_6LOWPAN_NHC_MOBILITY=m
# CONFIG_6LOWPAN_NHC_ROUTING is not set
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
CONFIG_6LOWPAN_GHC_UDP=m
CONFIG_6LOWPAN_GHC_ICMPV6=m
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=m
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=m
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_IPT=y
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_VSOCKETS=m
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_CALC_BITTIMING is not set
CONFIG_CAN_LEDS=y
# CONFIG_PCH_CAN is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
# CONFIG_CAN_C_CAN_PCI is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
# CONFIG_CAN_CC770_PLATFORM is not set
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
CONFIG_CAN_MCP251X=m
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
# CONFIG_BT_SELFTEST_ECDH is not set
# CONFIG_BT_SELFTEST_SMP is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=m
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=m
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=m
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
# CONFIG_MTD_M25P80 is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=m
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=m
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_PLATFORM is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_MWIFIEX is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_GPIO=m
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=m
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TWL4030=m
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=m
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_CHARGER_RT9455=m
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=m
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=y
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
# CONFIG_RDC321X_WDT is not set
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=m
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
CONFIG_MFD_CROS_EC_CHARDEV=m
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=m
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=m
CONFIG_CEC_PIN=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_PIN_ERROR_INJ is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_MEM2MEM_DEV=m

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
# CONFIG_SOC_CAMERA is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=m
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=m
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEO_V4L2_TPG=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_N411=m
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_SPI is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_ACCESSIBILITY=y
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI=y
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_IPOIB is not set
# CONFIG_RDMA_RXE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS80031=m
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=m
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
CONFIG_RTC_DRV_DS17885=y
# CONFIG_RTC_DS1685_PROC_REGS is not set
CONFIG_RTC_DS1685_SYSFS_REGS=y
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=m
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=m
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_PCAP=m
# CONFIG_RTC_DRV_MC13XXX is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_CRAMFS=m
CONFIG_CRAMFS_MTD=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFLATE_COMPRESS=m
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
CONFIG_CIFS_DEBUG_DUMP_KEYS=y
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
CONFIG_CODA_FS=y
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_STACK_TRACER is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_SORT=m
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=m
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
CONFIG_TEST_OVERFLOW=m
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=m
CONFIG_CRYPTO_MORUS640=m
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=m
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=m
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=m
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STRING_SELFTEST=m

--IDYEmSnFhs3mNXr+--
