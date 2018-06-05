Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeFEQpE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:45:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeFEQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:43:48 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: Jonathan Corbet <corbet@lwn.net>, Michal Suchanek <msuchanek@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/5] init/main.c: simplify repair_env_string.
Date: Tue,  5 Jun 2018 18:43:10 +0200
Message-Id: <f0d9664cf6e10cd89c8fa551885b91a75619b267.1528215659.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting characters are now removed from the parameter so value always
follows directly after the NUL terminating parameter name.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 init/main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4bc2819d97ad..d0f4a7a0f010 100644
--- a/init/main.c
+++ b/init/main.c
@@ -251,15 +251,10 @@ static int __init repair_env_string(char *param, char *val,
 				    const char *unused, void *arg)
 {
 	if (val) {
-		/* param=val or param="val"? */
-		if (val == param+strlen(param)+1)
-			val[-1] = '=';
-		else if (val == param+strlen(param)+2) {
-			val[-2] = '=';
-			memmove(val-1, val, strlen(val)+1);
-			val--;
-		} else
-			BUG();
+		int parm_len = strlen(param);
+
+		param[parm_len] = '=';
+		BUG_ON(val != param + parm_len + 1);
 	}
 	return 0;
 }
-- 
2.13.6
