Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ihQnGXhgGVtEQAAAmS7hNA
	; Thu, 07 Jun 2018 16:42:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 869FA607E7; Thu,  7 Jun 2018 16:42:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C6643606DD;
	Thu,  7 Jun 2018 16:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6643606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933376AbeFGQmt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:42:49 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38018 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932714AbeFGQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:42:47 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fQxzp-0008In-1s; Thu, 07 Jun 2018 17:42:45 +0100
Message-ID: <1528389764.2289.77.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sriram R <srirrama@codeaurora.org>, stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Jun 2018 17:42:44 +0100
In-Reply-To: <20180607161640.GB15950@kroah.com>
References: <20180514064754.853201981@linuxfoundation.org>
         <20180514064755.718467503@linuxfoundation.org>
         <1528134761.2289.45.camel@codethink.co.uk>
         <133624c2c44831fd70edb18c01508f64@codeaurora.org>
         <1528386597.2289.75.camel@codethink.co.uk>
         <20180607161640.GB15950@kroah.com>
Organization: Codethink Ltd.
Content-Type: multipart/mixed; boundary="=-I8x94VUAtOn0sj6Ksz9B"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I8x94VUAtOn0sj6Ksz9B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-06-07 at 18:16 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 07, 2018 at 04:49:57PM +0100, Ben Hutchings wrote:
> > On Thu, 2018-06-07 at 17:22 +0530, Sriram R wrote:
> > > Hi Ben,
> > > 
> > > On 2018-06-04 23:22, Ben Hutchings wrote:
> > > > On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
> > > > > 4.4-stable review patch.  If anyone has any objections, please let me 
> > > > > know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > > 
> > > > > commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> > > > > 
> > > > > Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> > > > > rx_hdr_status is not padded to align in 4-byte boundary. Define a
> > > > > new hw_params field to handle different alignment behaviour between
> > > > > different hw. This patch fixes improper retrieval of rfc1042 header
> > > > > with QCA4019. This patch along with "ath10k: Properly remove padding
> > > > > from the start of rx payload" will fix traffic failure in ethernet
> > > > > decap mode for QCA4019.
> > > > > 
> > > > > Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > > Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> > > > > Signed-off-by: Sriram R <srirrama@codeaurora.org>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > [...]
> > > > 
> > > > I'm curious as to why this backport doesn't include the change to
> > > > ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
> > > > new field is a dependency for the following patch, but shouldn't the
> > > > fix included in the upstream commit also be applied to 4.4?
> > > > 
> > > 
> > >    Our main intention with this patchset [1] was to provide fix for 
> > > replay detection security issue seen in ath10k driver which needed to be 
> > > in the stable releases.
> > > 
> > > And, as per stable tree guidelines we wanted the patchset to have only 
> > > one and this important fix .
> > 
> > OK, I think the problem here is that the rules say "must" when what's
> > really meant is "should".  So the rule "It must fix only one thing."
> > really means that commits that each make a single logical change are
> > strongly preferred.
> > 
> > It does not mean that upstream commits should be trimmed down to
> > conform to this.  Greg generally considers it more important to avoid
> > changes to the upstream commit, where possible.  Right, Greg?
> > 
> > And speaking only for myself, I particularly dislike stable backports
> > that are significantly different from the original upstream commit but
> > don't mention this difference in the commit message.
> 
> I _STRONGLY_ dislike backports that are different than what is in
> Linus's tree and normally I catch it when someone tries to do that.  I
> missed this one here, and that's not ok on my part for missing that, and
> for the authors part in doing that :(
> 
> So, what to do here, should I revert this series and take a fixed-up
> one?  What exactly is the stable tree now missing because of this
> mistake?

If you apply the attached patch, that should complete the backporting
of commit 2f38c3c01de9.  I'm not able to test the driver but the change
looks reasonable and it builds OK.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
--=-I8x94VUAtOn0sj6Ksz9B
Content-Disposition: attachment;
	filename*0=0001-ath10k-fix-rfc1042-header-retrieval-in-QCA4019-with-.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-ath10k-fix-rfc1042-header-retrieval-in-QCA4019-with-.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA4OTE2NmI3YmJjNWE1MGNhMjJhYmYyMjE1ZWVkNzRjNzg4Y2FlMjg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWYXNhbnRoYWt1bWFyIFRoaWFnYXJhamFuIDx2dGhpYWdhckBx
dGkucXVhbGNvbW0uY29tPgpEYXRlOiBNb24sIDI2IFNlcCAyMDE2IDIxOjU2OjI0ICswMzAwClN1
YmplY3Q6IFtQQVRDSF0gYXRoMTBrOiBmaXggcmZjMTA0MiBoZWFkZXIgcmV0cmlldmFsIGluIFFD
QTQwMTkgd2l0aCBldGgKIGRlY2FwIG1vZGUKCmNvbW1pdCAyZjM4YzNjMDFkZTk0NTIzNGQyM2Rk
MTYzZTM1MjhjY2I0MTMwNjZkIHVwc3RyZWFtLgoKQ2hpcHNldCBmcm9tIFFDQTk5WDAgb253YXJk
cyAoUUNBOTlYMCwgUUNBOTk4NCwgUUNBNDAxOSAmIGZ1dHVyZSkKcnhfaGRyX3N0YXR1cyBpcyBu
b3QgcGFkZGVkIHRvIGFsaWduIGluIDQtYnl0ZSBib3VuZGFyeS4gRGVmaW5lIGEKbmV3IGh3X3Bh
cmFtcyBmaWVsZCB0byBoYW5kbGUgZGlmZmVyZW50IGFsaWdubWVudCBiZWhhdmlvdXIgYmV0d2Vl
bgpkaWZmZXJlbnQgaHcuIFRoaXMgcGF0Y2ggZml4ZXMgaW1wcm9wZXIgcmV0cmlldmFsIG9mIHJm
YzEwNDIgaGVhZGVyCndpdGggUUNBNDAxOS4gVGhpcyBwYXRjaCBhbG9uZyB3aXRoICJhdGgxMGs6
IFByb3Blcmx5IHJlbW92ZSBwYWRkaW5nCmZyb20gdGhlIHN0YXJ0IG9mIHJ4IHBheWxvYWQiIHdp
bGwgZml4IHRyYWZmaWMgZmFpbHVyZSBpbiBldGhlcm5ldApkZWNhcCBtb2RlIGZvciBRQ0E0MDE5
LgoKU2lnbmVkLW9mZi1ieTogVmFzYW50aGFrdW1hciBUaGlhZ2FyYWphbiA8dnRoaWFnYXJAcXRp
LnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogS2FsbGUgVmFsbyA8a3ZhbG9AcWNhLnF1YWxj
b21tLmNvbT4KW2J3aDogVGhpcyBqdXN0IGFkZHMgdGhlIHBhcnQgdGhhdCB3YXMgbGVmdCBvdXQg
b2YgdGhlIHByZXZpb3VzIGJhY2twb3J0LAogY29tbWl0IGI4OGZiOWVhNDc1YS5dClNpZ25lZC1v
ZmYtYnk6IEJlbiBIdXRjaGluZ3MgPGJlbi5odXRjaGluZ3NAY29kZXRoaW5rLmNvLnVrPgotLS0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvaHR0X3J4LmMgfCA1ICsrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvaHR0X3J4LmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTBrL2h0dF9yeC5jCmluZGV4IGQyNmNiMzdiMWZiZC4uYjMyYzQ3ZmU5
MjZkIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTBrL2h0dF9yeC5j
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMGsvaHR0X3J4LmMKQEAgLTExNjYs
NiArMTE2Niw3IEBAIHN0YXRpYyB2b2lkICphdGgxMGtfaHR0X3J4X2hfZmluZF9yZmMxMDQyKHN0
cnVjdCBhdGgxMGsgKmFyLAogCXNpemVfdCBoZHJfbGVuLCBjcnlwdG9fbGVuOwogCXZvaWQgKnJm
YzEwNDI7CiAJYm9vbCBpc19maXJzdCwgaXNfbGFzdCwgaXNfYW1zZHU7CisJaW50IGJ5dGVzX2Fs
aWduZWQgPSBhci0+aHdfcGFyYW1zLmRlY2FwX2FsaWduX2J5dGVzOwogCiAJcnhkID0gKHZvaWQg
Kiltc2R1LT5kYXRhIC0gc2l6ZW9mKCpyeGQpOwogCWhkciA9ICh2b2lkICopcnhkLT5yeF9oZHJf
c3RhdHVzOwpAQCAtMTE4Miw4ICsxMTgzLDggQEAgc3RhdGljIHZvaWQgKmF0aDEwa19odHRfcnhf
aF9maW5kX3JmYzEwNDIoc3RydWN0IGF0aDEwayAqYXIsCiAJCWhkcl9sZW4gPSBpZWVlODAyMTFf
aGRybGVuKGhkci0+ZnJhbWVfY29udHJvbCk7CiAJCWNyeXB0b19sZW4gPSBhdGgxMGtfaHR0X3J4
X2NyeXB0b19wYXJhbV9sZW4oYXIsIGVuY3R5cGUpOwogCi0JCXJmYzEwNDIgKz0gcm91bmRfdXAo
aGRyX2xlbiwgNCkgKwotCQkJICAgcm91bmRfdXAoY3J5cHRvX2xlbiwgNCk7CisJCXJmYzEwNDIg
Kz0gcm91bmRfdXAoaGRyX2xlbiwgYnl0ZXNfYWxpZ25lZCkgKworCQkJICAgcm91bmRfdXAoY3J5
cHRvX2xlbiwgYnl0ZXNfYWxpZ25lZCk7CiAJfQogCiAJaWYgKGlzX2Ftc2R1KQotLSAKQmVuIEh1
dGNoaW5ncywgU29mdHdhcmUgRGV2ZWxvcGVyICAgICAgICAgICAgICAgICAgICAgICAgIENvZGV0
aGluayBMdGQKaHR0cHM6Ly93d3cuY29kZXRoaW5rLmNvLnVrLyAgICAgICAgICAgICAgICAgRGFs
ZSBIb3VzZSwgMzUgRGFsZSBTdHJlZXQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1hbmNoZXN0ZXIsIE0xIDJIRiwgVW5pdGVkIEtpbmdkb20KCg==


--=-I8x94VUAtOn0sj6Ksz9B--
