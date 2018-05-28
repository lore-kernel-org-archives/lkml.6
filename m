Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165137AbeE1NJG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:09:06 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:52955 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163879AbeE1NJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:09:03 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj@kernel.org'" <tj@kernel.org>
CC: "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: RE: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Topic: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Index: AdP2gtQcFftKX6rKRguW2o+iRXsAXgAAEZYw
Date: Mon, 28 May 2018 13:08:57 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B63E5E5@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 659a7431bc2f4c388f6ea403e307ad51
x-originating-ip: [10.124.136.24]
Content-Type: multipart/mixed;
        boundary="_002_33710E6CAA200E4583255F4FB666C4E21B63E5E5G01JPEXMBYT03_"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_33710E6CAA200E4583255F4FB666C4E21B63E5E5G01JPEXMBYT03_
Content-Type: text/plain; charset="iso-2022-jp"

Hi,

I attach a reproducer for this issue.

Expand repro.tar.gz and run two commands:

  # make
  # ./repro.sh

Then, repro.sh will terminate when the issue is reproduced.

In this reproducer, we prepare AtvbAC0jwH.ko and U1cN9ZbARQ.ko having the same hash value.
Then, install U1cN9ZbARQ.ko and then repeating installing and removing AtvbAC0jwH.ko over and over.
Note that AtvbAC0jwH is smaller than U1cN9ZbARQ in the string comparison.
The issue is that output of ls -1 /sys/module contains NO U1cN9ZbARQ.ko.

I found a pair of AtvbAC0jwH and U1cN9ZbARQ using kernhash.c, retrieved from fs/kernfs/dirs.c,
contained in repro.tar.gz like:

    # ./kernfshash
    AtvbAC0jwH U1cN9ZbARQ 6b2609c5

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Hatayama, Daisuke
> Sent: Monday, May 28, 2018 9:54 PM
> To: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>;
> 'tj@kernel.org' <tj@kernel.org>
> Cc: Okajima, Toshiyuki <toshi.okajima@jp.fujitsu.com>;
> linux-kernel@vger.kernel.org; 'ebiederm@aristanetworks.com'
> <ebiederm@aristanetworks.com>
> Subject: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
> 
> kernfs_dir_next_pos() overlooks the situation that the dentry
> corresponding to a given pos object has already been inactive. Hence,
> when kernfs_dir_pos() returns the dentry with a hash value larger than
> the original one, kernfs_dir_next_pos() returns the dentry next to the
> one returned by kernfs_dir_pos(). As a result, the dentry returned by
> kernfs_dir_pos() is skipped.
> 
> To fix this issue, try to find a next node only when the returned
> object is less than or equal to the original one.
> 
> Note that this implementation focuses on getting guarantee that the
> existing nodes are never skipped, not interested in the other nodes
> that are added or removed during the process.
> 
> We found this issue during a stress test that repeatedly reads
> /sys/module directory to get a list of the currently loaded kernel
> modules while repeatedly loading and unloading kernel modules
> simultaneously.
> 
> v2: Fix the case where nodes with the same hash but with the name
>     larger than the original node could still be skipped. Use
>     kernfs_sd_compare() to compare kernfs_node objects. Imporove patch
>     description.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Suggested-by: Toshiyuki Okajima <toshi.okajima@jp.fujitsu.com>
> Cc: Eric W. Biederman <ebiederm@aristanetworks.com>
> ---
>  fs/kernfs/dir.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 89d1dc1..3aeeb7a 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1621,8 +1621,10 @@ static int kernfs_dir_fop_release(struct inode *inode,
> struct file *filp)
>  static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
>  	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
>  {
> +	struct kernfs_node *orig = pos;
> +
>  	pos = kernfs_dir_pos(ns, parent, ino, pos);
> -	if (pos) {
> +	if (pos && kernfs_sd_compare(pos, orig) <= 0) {
>  		do {
>  			struct rb_node *node = rb_next(&pos->rb);
>  			if (!node)
> --
> 1.7.1
> 
> 
> 
> 
> 
> 


--_002_33710E6CAA200E4583255F4FB666C4E21B63E5E5G01JPEXMBYT03_
Content-Type: application/x-gzip; name="repro.tar.gz"
Content-Description: repro.tar.gz
Content-Disposition: attachment; filename="repro.tar.gz"; size=2394;
	creation-date="Mon, 28 May 2018 12:57:06 GMT";
	modification-date="Mon, 28 May 2018 12:57:06 GMT"
Content-Transfer-Encoding: base64

H4sIACh4DFsAA+1ae3PTxhbnX2sm3+FgKJWT2JIsP0JM0gk0t9AmgebCLS3l
amRpZW8iS0aS8yjlfvZ7dldvOyGdhnQ63d9ksLx7Xnteu9bS0SIyj0Lt3heE
jhj2+/wTUf/kz4Zp6qY+7Onm4J5uGLo5vAf9L2lUhkWc2BHAvSgMk+voPjf/
N0Unjb8b0TMSfZk0+OPx75pmV8b/LlCL/15yNt57pp+cP+84t6aDBXjQ610Z
f7Pby+JvdvtIZ/TMLta/fmsWXIN/ePwf0MDxFy6BJz4NFhfaKYkC4nemu0p9
Zha6C5+smnGJb1+yCQV9mVAHaJCAZdGAJuCFIX9Qz0LqtpSPSiMiySIKQB8p
n3IGNokc5CLlYA85B5IJ3UJQJrE1yoY5dcaGw3+1T/9OqNX/G8M5evzLeO/4
x7+2/o1hX9b/XUDW/z8btfo/tE+JR31yqzo+W/+6mde/aeI50TCHA7n/3wnC
8Ul7Bts7UDr5hVDaBkJFcYlnL/xkW2k8VA/3fthvQfsZaD4dpz0h1h6q8ZT4
PiwCe0agHbW08YL6LhzuZDPzc7cFKbmiOD6xgz8vj4uR5f5nkNU/6/tePLXj
6S1u/Cn477/luk8/DX3YHRT7/4Dt/6bZ02X93wWKvTxOXBriLr6mVMawLJcG
IxpMlilx168N+nRGk7g2mNAZ4UNrSnI5J9hcYIGsZtdKYGF2R9XhQY8ND3oj
Rv8AR2lA4LuXB9/uH1nHe69fvLTMLugXA+PZ1tagN7yCZtAraAZb+tP+lrn/
dOH7ZaGWxbKficufrAkJSEQdRpYfbXxGvFhFprLRM9tvrSkf1/KDDg7Aet1k
XM6nklTLsv1z+zK2SuK5cFx+LhwXgbI2sSnGdBIQlx+zxujgVJ+2DoPexaDX
xjGYYcOmc/8SaAzE86hDCVKHAdjYPFMarHuHxHEYxbCuXWswqt7dBRU/2kKj
sD9zXWpq3eQagR8GE5WvgIvIqEtDV0Tv1fGLw/26QeXQseOgxbYKHhE1tv2k
1WiouaOY5pYYXhHKMtWaMrejhNp+SVyFAJzNKgd6kZwxumrU1WwYNkB14MkT
6LXEIzqy12qhhw0jywJtfU15PRVuwtICbxE4CcVg0QBI4JZsabF4Ysf2bQf1
2wmc9TrGsB05JnhROMPaQTFml4cXz3MxE5KEwEbToIcB6TCdkJ3eRTnzzj/d
3QaPXizp9MII2Rm38BHANEnm8bamTWgyXYw7TjjTkjDCSLqxJsTiEBa/Zjwe
P7bdwdA0dOJ2vcFWXx90bV23iTPQu2PimOaW2fd09ByT+wBQIrgkdiI6JnBz
bsg90W2bj832JGVdU1hqXxFxVkDVtVZDWwqrpqWBzateVctyWpx2BJoGY4L+
IkVkiqQoyoA9bWKgBIftJSSqMOTqlpVwjuPn+wfDTj+LcZ5HsJhjPIk9y6PP
lp87oLJyseWXFu+EQZyAM8X9cJ2NboIY4b/O1oOszyz7CHbqJRjwFtGo6PNJ
gIRoHj6ojJSTnE/x5waoONZuo4JGIxW4XIfcpo2NTREWxpuSVkNYnX20g51/
6Am8GYk2eUxiEp2JeoNgMRujr0DfBAPswIUXR6+tw723POtn9gTd5tKIOJjf
l6gKq4Wk/ZJ6wLXBE+gWpm/sAGvvxezuTiayvL5MSxtYGyhnSNYVHqAEnQe1
Fm24JqXzmFjzJFLL8cPvV+4dkGIpT2s9lMsobQC3mliZETfPryWOK9Mso6xl
G9Rw89yrcagrchD+WwRCFUttBTFWvdFakrCUptnsrWVrJrCWtCs9kKbwEksl
k6/wXTWvVyRWenRAh1GvlEHcQRGuKJxZ8eVsHPqqSJjxwtuEmP5GLB7btAml
XJzEJwn2z/jde1TftMcOngomU3py6s+CcP4hipPF2fnF5W97T599u/+v756/
+P6Hg8Ojl69+PP736zf/+entz7+wC6defzDcemw1+UGzgUrfoTIm8etf9a9X
NqoSTWYBsx/3y69AZQaHnppOtJg7Wu+LookWTsLDcwkf630ydVKDr0244p2h
c+ZR5fiSSrBwq8WMJZVqt6s1Nk7dJsYq+tfnuAB7dMXkB5wcC5+kMZy3d0Wo
d+BD+vgN61ONxnY+96Q0ZYiptlFrGcx+PL25abRjXEbg+RQPPsFEVBF/AVi2
u9oZxnZMLOEB5m001HhzwE5aXX3EM6S8Dka8tCPRUZFJ7HvM4me5eERKswCZ
UOwMz8yho9b1rUMa5LImXtq8999n9C0e3sacRFEYqU0hqclpMn9yxzS4ZwRf
YUXKzQdU9rtJPXpzcCBUNAoytvJURoO1AZXiiD4CinGoGT2CjQ2aia04iEl5
xKjf0fdi9Y1qNZL2rnjCzqMLE0iWCsstv0TNbS7W+AF/cCTcmZt16zZXenSz
muYtYd0fWOhyITVWV1x19GSlG+o+uMoBS6sXFp8Ii09WW3ySWswTgQfj5H0n
raj0MIqTjTGe8E5HqwmxLMXuIwQ15ni6Tzy1+VUM7E/fuvg1aG5CZl7Gm33P
T08ILyKEC88G0ow1xFeWbvwfEdcqdf6WPy165tCZTQOVPdjRBH9Gifa+jl/O
0ipni2FzsIvdUiwgL9Mi4IYIOCMsR1mEeV0shLU0lCtyubEi3DcJGecs+U+/
WHJf4S7uCCA+dozc8IjPuGFqYIRKr+94rSKoES5RX4r3p+wEcz/KSgrnl/x9
8/c/2fs//m8nnn6Jd0yf+/8fw+6weP/Pxo1uv9uT7//uAg/ugzamgYaFO1WU
aDYL3dJVAHR3NZecacHC99PJ4mqgMqnk7yxOqe9bbGs6t/HIToMYuaz0VROJ
8XT0kZ8KGRk8TKcLjdacunyecV81/0lJInsOzetVNWH/7YvXiiLGobPijvs0
RMNZX1FHI9xWwQ257jpH6W7kVFDUHaXwffiRstLenebDb5qrFXlwH/wYzwCg
xZdxev8Bv8ME6xHaH/ZL7h6xtziBIpoB5/YoV6soxJmG0DxmJewuHOI2b94A
svr/Ihd/KT53/9ftF+//+31R/3pX1v9doPPq+cujn7chveMDcc8mLtbyiz8x
qij8Y1tpTBwH2j/hH3uZ3KncHUE7hOK70phhXrHrvayWiru/aAZt71ra1AxO
GXmw/j951SchISEhISEhISEhISEhISEhISEhISEhISEhISEhISEhISEhIZHj
/6mo8CMAUAAA

--_002_33710E6CAA200E4583255F4FB666C4E21B63E5E5G01JPEXMBYT03_--
