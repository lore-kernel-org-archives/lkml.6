Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeCWIMX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:12:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:47822 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeCWIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:12:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="40527850"
Date: Fri, 23 Mar 2018 10:12:10 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180323081210.GA28857@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
 <20180214134319.4400-3-tomas.winkler@intel.com>
 <20180219115221.7kd3ks7mrzmw36mz@linux.intel.com>
 <1519136010.4113.10.camel@linux.intel.com>
 <20180305180831.GB6220@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305180831.GB6220@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 08:08:31PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 20, 2018 at 04:13:30PM +0200, Jarkko Sakkinen wrote:
> > On Mon, 2018-02-19 at 13:52 +0200, Jarkko Sakkinen wrote:
> > > On Wed, Feb 14, 2018 at 03:43:19PM +0200, Tomas Winkler wrote:
> > > > We cannot use go_idle cmd_ready commands via runtime_pm handles
> > > > as with the introduction of localities this is no longer an
> > > > optional
> > > > feature, while runtime pm can be not enabled.
> > > > Though cmd_ready/go_idle provides power saving feature, it's also
> > > > part of
> > > > TPM2 protocol and should be called explicitly.
> > > > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > > > runtime pm support as it is not used by any driver.
> > > > 
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > ---
> > > > V2: resent
> > > > V3: resent
> > > 
> > > Only the cover letter needs a backlog but the code change looks
> > > good to me.
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > /Jarkko
> 
> Applied.
> 
> /Jarkko

This commit breaks my smoke tests on Kabylake [1] so I need to drop it.
The bug fix for locality works without any issues.

[1]
$ python -m unittest -v tpm2_smoke
test_seal_with_auth (tpm2_smoke.SmokeTest) ... ok
test_seal_with_policy (tpm2_smoke.SmokeTest) ... ok
test_seal_with_too_long_auth (tpm2_smoke.SmokeTest) ... ok
test_too_short_cmd (tpm2_smoke.SmokeTest) ... ok
test_unseal_with_wrong_auth (tpm2_smoke.SmokeTest) ... ok
test_unseal_with_wrong_policy (tpm2_smoke.SmokeTest) ... ok
test_flush_context (tpm2_smoke.SpaceTest) ... ERROR
test_get_handles (tpm2_smoke.SpaceTest) ... ERROR
test_invalid_cc (tpm2_smoke.SpaceTest) ... ok
test_make_two_spaces (tpm2_smoke.SpaceTest) ... ERROR

======================================================================
ERROR: test_flush_context (tpm2_smoke.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_smoke.py", line 185, in test_flush_context
    space1.flush_context(root1)
  File "tpm2.py", line 517, in flush_context
    self.send_cmd(cmd)
  File "tpm2.py", line 378, in send_cmd
    raise ProtocolError(cc, rc)
ProtocolError: TPM_RC_UNKNOWN: cc=0x00000165, rc=0x00000165

======================================================================
ERROR: test_get_handles (tpm2_smoke.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_smoke.py", line 195, in test_get_handles
    space2.create_root_key()
  File "tpm2.py", line 562, in create_root_key
    return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
  File "tpm2.py", line 378, in send_cmd
    raise ProtocolError(cc, rc)
ProtocolError: TPM_RC_UNBALANCED: cc=0x00000131, rc=0x00000131

======================================================================
ERROR: test_make_two_spaces (tpm2_smoke.SpaceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tpm2_smoke.py", line 171, in test_make_two_spaces
    root3 = space2.create_root_key()
  File "tpm2.py", line 562, in create_root_key
    return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
  File "tpm2.py", line 378, in send_cmd
    raise ProtocolError(cc, rc)
ProtocolError: TPM_RC_UNBALANCED: cc=0x00000131, rc=0x00000131

----------------------------------------------------------------------
Ran 10 tests in 44.545s

FAILED (errors=3)

/Jarkko
