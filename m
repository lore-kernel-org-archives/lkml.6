Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224KzCJ2VrjZyhUY1TegVeddOQL2i+vS4fA5V4+BcQWNYbk4m0wgEZ7z0xE00dUHj6qF6b96
ARC-Seal: i=1; a=rsa-sha256; t=1519411097; cv=none;
        d=google.com; s=arc-20160816;
        b=UUmVTH3NWt61aoyulrFXZjx9GqhuORFj+g6b+uTB8IlF7kADzcsGB3gwfTenMAmywN
         3jt+yhGThpqaZTRFi5z4v5bC+iqMLPHu6F91356Kjo4A+R/FTHpCqgKzeQM2vf0gGB1x
         wAM0YLc5P4NJM22UMlskMn/VPpJhCggU1Mi+0jcnyVxzv5vNnK1z/CpP3Y9Kg2FYViHe
         IlyGLZ/xIT96nQ9pvxE1W4s4FeKKvN8MHYFfxkMpilyDPyrcISTP+BZWVQCdfY6U0EXP
         zCNxSl0BwBLER4/BZAvhp35rvM4nB+1bHlqx+BKX7lQaImOFf8Uj3tM+epVT47NmpaD6
         Pr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1XkGpCmzdCHJ5C3Ndngc9cME330LHeZPJ03+RMu1BJk=;
        b=eAiQg3eeTws++WliHWe8V9aGni9WzKxGw7DoktioMEAfYn5X5z1oT2X8vwIvVQFOin
         TVB3zCpp/gFqMIP37OI1TtsBxfs26vhdiDN9LIyhoXLaQuzhGUxCecBLsBtXMJmB798K
         /FCKmGMoK5GKLPEiVOOh2Wof4EkPBjeWDFEWMM2lSwZ9ZVTe2o3BrtSi82HscBxigWMg
         DsjXKCwde98SkASJG9KYQ+rp9nH+ogKd90KonZScrZvBcXZilb8op2m4HlXmMFo4fzTu
         DEcjZ0cXeLhAknM3GXvpvqSYohs2Q6SCVa4lWPzactXq4o99fzXQLb4HwniffLg4IjZ4
         ThMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Michal Marek <mmarek@suse.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 072/193] tools build: Add tools tree support for make -s
Date: Fri, 23 Feb 2018 19:25:05 +0100
Message-Id: <20180223170337.252974260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218010959624529?=
X-GMAIL-MSGID: =?utf-8?q?1593218010959624529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit e572d0887137acfc53f18175522964ec19d88175 upstream.

When doing a kernel build with 'make -s', everything is silenced except
the objtool build.  That's because the tools tree support for silent
builds is some combination of missing and broken.

Three changes are needed to fix it:

- Makefile: propagate '-s' to the sub-make's MAKEFLAGS variable so the
  tools Makefiles can see it.

- tools/scripts/Makefile.include: fix the tools Makefiles' ability to
  recognize '-s'.  The MAKE_VERSION and MAKEFLAGS checks are copied from
  the top-level Makefile.  This silences the "DESCEND objtool" message.

- tools/build/Makefile.build: add support to the tools Build files for
  recognizing '-s'.  Again the MAKE_VERSION and MAKEFLAGS checks are
  copied from the top-level Makefile.  This silences all the object
  compile/link messages.

Reported-and-Tested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michal Marek <mmarek@suse.com>
Link: http://lkml.kernel.org/r/e8967562ef640c3ae9a76da4ae0f4e47df737c34.1484799200.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile                       |    6 ++++--
 tools/build/Makefile.build     |   10 ++++++++++
 tools/scripts/Makefile.include |   12 +++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -87,10 +87,12 @@ endif
 ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
   quiet=silent_
+  tools_silent=s
 endif
 else					# make-3.8x
 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
   quiet=silent_
+  tools_silent=-s
 endif
 endif
 
@@ -1523,11 +1525,11 @@ image_name:
 # Clear a bunch of variables before executing the submake
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/ $*
 
 # Single targets
 # ---------------------------------------------------------------------------
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -19,6 +19,16 @@ else
   Q=@
 endif
 
+ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
+ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
+  quiet=silent_
+endif
+else					# make-3.8x
+ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+  quiet=silent_
+endif
+endif
+
 build-dir := $(srctree)/tools/build
 
 # Define $(fixdep) for dep-cmd function
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -46,6 +46,16 @@ else
 NO_SUBDIR = :
 endif
 
+ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
+ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
+  silent=1
+endif
+else					# make-3.8x
+ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+  silent=1
+endif
+endif
+
 #
 # Define a callable command for descending to a new directory
 #
@@ -58,7 +68,7 @@ descend = \
 QUIET_SUBDIR0  = +$(MAKE) $(COMMAND_O) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifneq ($(silent),1)
   ifneq ($(V),1)
 	QUIET_CC       = @echo '  CC       '$@;
 	QUIET_CC_FPIC  = @echo '  CC FPIC  '$@;
